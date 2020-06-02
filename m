Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D291EBF55
	for <lists+linux-edac@lfdr.de>; Tue,  2 Jun 2020 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBPso (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Jun 2020 11:48:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgFBPso (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Jun 2020 11:48:44 -0400
Received: from zn.tnic (p200300ec2f0bbb004c909b752ca088bd.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bb00:4c90:9b75:2ca0:88bd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D9271EC038A;
        Tue,  2 Jun 2020 17:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591112923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fCE7XnSzuHCBf0EmgG3ZG39d7yjE0cZazFJrEr58cHE=;
        b=fAoQPsCm79xYXWrZ6kEAimJr0hQAGlNoqVWQQaEsH1RK2gWMFeOTiNP4cBcFCmagH/n6Hh
        +s/bO0IYd3b4HhIsCLJ+RYAfLW7Zpvt5BslquT6QoQsBpSX/3cGpmyx32mBexAiPSQh63T
        9V5Ep1+sS3p5RxBZfWfIFM4BqlpWRDk=
Date:   Tue, 2 Jun 2020 17:48:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/ghes: Setup DIMM label from DMI and use it in
 error reports
Message-ID: <20200602154843.GD11634@zn.tnic>
References: <20200528101307.23245-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528101307.23245-1-rrichter@marvell.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 28, 2020 at 12:13:06PM +0200, Robert Richter wrote:
> The ghes driver reports errors with 'unknown label' even if the actual
> DIMM label is known, e.g.:
> 
>  EDAC MC0: 1 CE Single-bit ECC on unknown label (node:0 card:0
>    module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM location:N0 DIMM_A0
>    page:0x966a9b3 offset:0x0 grain:1 syndrome:0x0 - APEI location:
>    node:0 card:0 module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM
>    location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
>    DRAM memory)
> 
> Fix this by using struct dimm_info's label string in error reports:
> 
>  EDAC MC0: 1 CE Single-bit ECC on N0 DIMM_A0 (node:0 card:0 module:0
>    rank:1 bank:515 col:14 bit_pos:16 DIMM location:N0 DIMM_A0
>    page:0x99223d8 offset:0x0 grain:1 syndrome:0x0 - APEI location:
>    node:0 card:0 module:0 rank:1 bank:515 col:14 bit_pos:16 DIMM
>    location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
>    DRAM memory)
> 
> The labels are initialized by reading the bank and device strings from
> DMI. Now, the label information can also read from sysfs. E.g. a
> ThunderX2 system will show the following:
> 
>  /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
>  /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
>  /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
>  /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
>  /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
>  /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
>  /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
>  /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
>  /sys/devices/system/edac/mc/mc0/dimm8/dimm_label:N1 DIMM_I0
>  /sys/devices/system/edac/mc/mc0/dimm9/dimm_label:N1 DIMM_J0
>  /sys/devices/system/edac/mc/mc0/dimm10/dimm_label:N1 DIMM_K0
>  /sys/devices/system/edac/mc/mc0/dimm11/dimm_label:N1 DIMM_L0
>  /sys/devices/system/edac/mc/mc0/dimm12/dimm_label:N1 DIMM_M0
>  /sys/devices/system/edac/mc/mc0/dimm13/dimm_label:N1 DIMM_N0
>  /sys/devices/system/edac/mc/mc0/dimm14/dimm_label:N1 DIMM_O0
>  /sys/devices/system/edac/mc/mc0/dimm15/dimm_label:N1 DIMM_P0
> 
> Since dimm_labels can be rewritten, that label will be used in a later
> error report:
> 
>  # echo foobar >/sys/devices/system/edac/mc/mc0/dimm0/dimm_label
>  # # some error injection here
>  # dmesg | grep foobar
>  [ 751.383533] EDAC MC0: 1 CE Single-bit ECC on foobar (node:0 card:0
>  module:0 rank:1 bank:259 col:3 bit_pos:16 DIMM location:N0 DIMM_A0
>  page:0x8c8dc74 offset:0x0 grain:1 syndrome:0x0 - APEI location:
>  node:0 card:0 module:0 rank:1 bank:259 col:3 bit_pos:16 DIMM
>  location:N0 DIMM_A0 status(0x0000000000000400): Storage error in DRAM
>  memory)
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
> v4:
> 
>  * dimm->label: Only update dimm->label in if bank/device is found in
>    the SMBIOS table, this keeps current behavior for machines that do
>    not provide this information.
> 
>  * e->location: Keep current behavior how e->location is written.
> 
>  * e->label: Use dimm->label if a DIMM was found by its handle and
>    "unknown memory" otherwise. This aligns with the edac_mc
>    implementation.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)

Yap, looks good. I'll queue it after the merge window.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
