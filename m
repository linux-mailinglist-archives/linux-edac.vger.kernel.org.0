Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B17186832
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgCPJvk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 05:51:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgCPJvk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 05:51:40 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7EE01EC0B89;
        Mon, 16 Mar 2020 10:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584352299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ifYntF04mk/uMnlnJ+xuphFsg2r2jtgAWgf2i801nHc=;
        b=UAhCiAvp8/NUrep2e/FeG7v22OrCD0yHwL8spX3n72j90tddnXvZ7W+BwsT86+CzAh4jrU
        RVNY2bzaJF+W4FD0Q6FroOPMpQjcKlXRkYUcJxjApO2NZWwmY3S9TAhuLSHgEW88+TA5mz
        0okS+q4Kb8awXvS9Erugd7AWeFUPiTI=
Date:   Mon, 16 Mar 2020 10:51:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 11/11] EDAC/ghes: Create one memory controller per
 physical memory array
Message-ID: <20200316095149.GE26126@zn.tnic>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-12-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306151318.17422-12-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 06, 2020 at 04:13:18PM +0100, Robert Richter wrote:
> The ghes driver only creates one memory controller for the whole
> system. This does not reflect memory topology especially in multi-node
> systems. E.g. a Marvell ThunderX2 system shows:
> 
>  /sys/devices/system/edac/mc/mc0/dimm0
>  /sys/devices/system/edac/mc/mc0/dimm1
>  /sys/devices/system/edac/mc/mc0/dimm2
>  /sys/devices/system/edac/mc/mc0/dimm3
>  /sys/devices/system/edac/mc/mc0/dimm4
>  /sys/devices/system/edac/mc/mc0/dimm5
>  /sys/devices/system/edac/mc/mc0/dimm6
>  /sys/devices/system/edac/mc/mc0/dimm7
>  /sys/devices/system/edac/mc/mc0/dimm8
>  /sys/devices/system/edac/mc/mc0/dimm9
>  /sys/devices/system/edac/mc/mc0/dimm10
>  /sys/devices/system/edac/mc/mc0/dimm11
>  /sys/devices/system/edac/mc/mc0/dimm12
>  /sys/devices/system/edac/mc/mc0/dimm13
>  /sys/devices/system/edac/mc/mc0/dimm14
>  /sys/devices/system/edac/mc/mc0/dimm15
> 
> The DIMMs 9-15 are located on the 2nd node of the system. On
> comparable x86 systems there is one memory controller per node. The
> ghes driver should also group DIMMs depending on the topology and
> create one MC per node.
> 
> There are several options to detect the topology. ARM64 systems
> retrieve the (NUMA) node information from the ACPI SRAT table (see
> acpi_table_parse_srat()). The node id is later stored in the physical
> address page. The pfn_to_nid() macro could be used for a DIMM after
> determining its physical address. The drawback of this approach is
> that there are too many subsystems involved it depends on. It could
> easily break and makes the implementation complex. E.g. pfn_to_nid()
> can only be reliable used on mapped address ranges which is not always
> granted, there are various firmware instances involved which could be
> broken, or results may vary depending on NUMA settings.
> 
> Another approach that was suggested by James' is to use the DIMM's
> physical memory array handle to group DIMMs [1]. The advantage is to
> only use the information on memory devices from the SMBIOS table that
> contains a reference to the physical memory array it belongs too. This
> information is mandatory same as the use of DIMM handle references by
> GHES to provide the DIMM location of an error. There is only a single
> table to parse which eases implementation. This patch uses this
> approach for DIMM grouping.
> 
> Modify the DMI decoder to also detect the physical memory array a DIMM
> is linked to and create one memory controller per array to group
> DIMMs. With the change DIMMs are grouped, e.g. a ThunderX2 system
> shows one MC per node now:
> 
>  # grep . /sys/devices/system/edac/mc/mc*/dimm*/dimm_label
>  /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
>  /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
>  /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
>  /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
>  /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
>  /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
>  /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
>  /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
>  /sys/devices/system/edac/mc/mc1/dimm0/dimm_label:N1 DIMM_I0
>  /sys/devices/system/edac/mc/mc1/dimm1/dimm_label:N1 DIMM_J0
>  /sys/devices/system/edac/mc/mc1/dimm2/dimm_label:N1 DIMM_K0
>  /sys/devices/system/edac/mc/mc1/dimm3/dimm_label:N1 DIMM_L0
>  /sys/devices/system/edac/mc/mc1/dimm4/dimm_label:N1 DIMM_M0
>  /sys/devices/system/edac/mc/mc1/dimm5/dimm_label:N1 DIMM_N0
>  /sys/devices/system/edac/mc/mc1/dimm6/dimm_label:N1 DIMM_O0
>  /sys/devices/system/edac/mc/mc1/dimm7/dimm_label:N1 DIMM_P0
> 
> [1] https://lkml.kernel.org/r/f878201f-f8fd-0f2a-5072-ba60c64eefaf@arm.com
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 137 ++++++++++++++++++++++++++++++---------
>  1 file changed, 107 insertions(+), 30 deletions(-)

This is all fine and good but that change affects the one x86 platform
we support so the whole patchset should be tested there too. Adding
Toshi.

As a matter of fact, the final version of this set should be tested on
all platforms which are using this thing. Adding John Garry too who
reported issues with this driver recently on his platform.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
