Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04257EE2A
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfHBH7L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 03:59:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34525 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfHBH7K (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Aug 2019 03:59:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so76203520wrm.1;
        Fri, 02 Aug 2019 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mDo7p75xMOujQk/V2A1la918Hsts2w3sSJwRBgcjfjY=;
        b=a32AeCRZIARmfokJQnVpbKosdsHDsNtIPcEnW986iL4vycmp65CtpfXe3iL5DW2Jec
         oYXS7BN4y87wKM2+5B5pmmXpqo5u1mzkLEpGScmPUUInsMkS0ra7XClOZrC7M9XI81Pq
         rAetzEBjUNNSo8Kse2lxL1RNoUoLeuPe9eMFCr8FDDYiMTVT1X1OysVvhtT6eGvf6AuT
         /F6La2cQTX5ScGRDT8lEOZ3qbLjNwqrjK7VTr/n/mcXpRmc+qMta7NdBzDA143oFlmyI
         K4ctNCQ6zH+P0p5dGZcbKG9dWqpsDSke0+TFtChtyJo/3Zxdoxeb7d2QjOMyTioGx286
         raCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mDo7p75xMOujQk/V2A1la918Hsts2w3sSJwRBgcjfjY=;
        b=D/stEw5CcUM0G66J3d+OPiGxTdGyQlvtAq4HvNlt7/S/0pJK7kX0TAlcxwWaI1NaM1
         xKngwNJijqnNLy4DHiAwivLhVazdovgoAs0FHGSd2mDAtzn5PyXApftnvXwC4WhCZ+PB
         gNuG+DdIDNwdc7peCE38WHhK6/+HN0/DwjE1UcE6cKkBhvsHFMZw0c4AzvYlwUh99AIh
         KvoO4dDcYxM1jF5x8TCJ8HHNLUvwK5Dyj9qJBSj70lwA5lECSNcff39KupU66U5VnT54
         e1228ZE/hG9nG6oJyJNJX9nsBn8bg3Nl8kd/aNSatbQNJXLVUu/z84R9SK497bfxTd6t
         1ScA==
X-Gm-Message-State: APjAAAVpySSduHBVuuSVltZ859GVqjqVYd0aDZOfxI3JD9l/cQWUqneN
        kXNjGOvJLjeYwo6euPv041A=
X-Google-Smtp-Source: APXvYqyo1MuWKJz5qxkb4XwptLgqmq38QbqQQDDXgwbGMe1uFVxfiPYXjiT5WcBfcVbnX9+RqZmqQQ==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr53938738wrs.200.1564732747352;
        Fri, 02 Aug 2019 00:59:07 -0700 (PDT)
Received: from rric.localdomain (x4e375ad3.dyn.telefonica.de. [78.55.90.211])
        by smtp.gmail.com with ESMTPSA id t15sm65935260wrx.84.2019.08.02.00.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 00:59:06 -0700 (PDT)
Date:   Fri, 2 Aug 2019 09:58:55 +0200
From:   Robert Richter <rric@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] EDAC, mc, ghes: Fixes and updates to improve
 memory error reporting
Message-ID: <20190802075854.ydrlufwvdxcjk7jj@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-1-rrichter@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

this is a friendly ping for review of this series.

Thanks,

-Robert

On 24.06.19 15:08:52, Robert Richter wrote:
> Current arm64 systems that use the ghes driver lack kernel support for
> a proper memory error reporting. Following issues are seen:
> 
>  * Error record shows insufficient data, such as "EDAC MC0: 1 CE
>    unknown error on unknown label",
> 
>  * DMI DIMM labels are not decoded for error reporting,
> 
>  * No memory hierarchy known (NUMA topology),
> 
>  * No per layer reporting,
> 
>  * Significant differences to x86 error reports.
> 
> This patch set addresses all the above involving a rework of the
> ghes_edac and edac_mc driver.
> 
> Patch #1-#4: Fix of grain calculation in edac_mc.c (#1) and
> ghes_edac.c (#2) including unification of trace_mc_event() code (#3,
> #4).
> 
> Patches #5-#12: General fixes and improvements of the ghes and mc
> drivers. Most of it is a rework of existing code without functional
> changes to improve, ease, cleanup and join common code. The changes
> are in preparation of and a requirment for the following patches that
> improve ghes error reports.
> 
> Patches #13-#22: Improve error memory reporting of the ghes driver
> including:
> 
>  * support for legacy API (patch #12),
> 
>  * NUMA detection, one mc device per node (patches #13-#16),
> 
>  * support for DMI DIMM label information (patch #17),
> 
>  * per-layer reporting (patches #18-#20).
> 
> Patch #23: Documentation updates.
> 
> Patch #24: Disable legacy API for ARM64 ghes driver (optional, need to
> be ack'ed by James, I vote for not applying it).
> 
> All changes should keep existing systems working as before. All
> systems that are using ghes will also benefit from the update. There
> is a fallback in the ghes driver that disables NUMA or enters a fake
> mode if some of the NUMA or DIMM information is inconsistent. So it
> should not break existing systems that provide broken firmware tables.
> 
> The series has been tested on a Marvell/Cavium ThunderX2 system. Here
> some example logs and sysfs entries:
> 
> Boot log of memory hierarchy and dimm detection:
> 
>  EDAC DEBUG: mem_info_setup: DIMM0: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x0038, label: N0 DIMM_A0
>  EDAC DEBUG: mem_info_setup: DIMM1: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x0039, label: N0 DIMM_B0
>  EDAC DEBUG: mem_info_setup: DIMM2: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x003a, label: N0 DIMM_C0
>  EDAC DEBUG: mem_info_setup: DIMM3: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x003b, label: N0 DIMM_D0
>  EDAC DEBUG: mem_info_setup: DIMM4: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x003c, label: N0 DIMM_E0
>  EDAC DEBUG: mem_info_setup: DIMM5: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x003d, label: N0 DIMM_F0
>  EDAC DEBUG: mem_info_setup: DIMM6: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x003e, label: N0 DIMM_G0
>  EDAC DEBUG: mem_info_setup: DIMM7: Found mem range [0x0000008800000000-0x0000009ffcffffff] on node 0, handle: 0x003f, label: N0 DIMM_H0
>  EDAC DEBUG: mem_info_setup: DIMM8: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x004f, label: N1 DIMM_I0
>  EDAC DEBUG: mem_info_setup: DIMM9: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0050, label: N1 DIMM_J0
>  EDAC DEBUG: mem_info_setup: DIMM10: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0051, label: N1 DIMM_K0
>  EDAC DEBUG: mem_info_setup: DIMM11: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0052, label: N1 DIMM_L0
>  EDAC DEBUG: mem_info_setup: DIMM12: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0053, label: N1 DIMM_M0
>  EDAC DEBUG: mem_info_setup: DIMM13: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0054, label: N1 DIMM_N0
>  EDAC DEBUG: mem_info_setup: DIMM14: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0055, label: N1 DIMM_O0
>  EDAC DEBUG: mem_info_setup: DIMM15: Found mem range [0x0000009ffd000000-0x000000bffcffffff] on node 1, handle: 0x0056, label: N1 DIMM_P0
> 
> DIMM label entries in sysfs:
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
> Memory error reports in the kernel log:
> 
>  {1}[Hardware Error]:  Error 4, type: corrected
>  {1}[Hardware Error]:   section_type: memory error
>  {1}[Hardware Error]:   error_status: 0x0000000000000400
>  {1}[Hardware Error]:   physical_address: 0x000000bd0db44000
>  {1}[Hardware Error]:   node: 1 card: 3 module: 0 rank: 0 bank: 256 column: 10 bit_position: 16 
>  {1}[Hardware Error]:   DIMM location: N1 DIMM_L0 
>  EDAC MC1: 1 CE ghes_mc on N1 DIMM_L0 (card:3 module:0 page:0xbd0db44 offset:0x0 grain:0 syndrome:0x0 - APEI location: node:1 card:3 module:0 rank:0 bank:256 col:10 bit_pos:16 handle:0x0052 status(0x0000000000000400): Storage error in DRAM memory)
> 
> Error counters in sysfs (zero counters dropped):
> 
>  # find /sys/devices/system/edac/mc/ -name \*count | sort -V | xargs grep . | sed -e '/:0/d'
>  /sys/devices/system/edac/mc/mc0/ce_count:5
>  /sys/devices/system/edac/mc/mc0/csrow0/ce_count:1
>  /sys/devices/system/edac/mc/mc0/csrow0/ch0_ce_count:1
>  /sys/devices/system/edac/mc/mc0/csrow3/ce_count:1
>  /sys/devices/system/edac/mc/mc0/csrow3/ch0_ce_count:1
>  /sys/devices/system/edac/mc/mc0/csrow4/ce_count:1
>  /sys/devices/system/edac/mc/mc0/csrow4/ch0_ce_count:1
>  /sys/devices/system/edac/mc/mc0/csrow6/ce_count:2
>  /sys/devices/system/edac/mc/mc0/csrow6/ch0_ce_count:2
>  /sys/devices/system/edac/mc/mc0/dimm0/dimm_ce_count:1
>  /sys/devices/system/edac/mc/mc0/dimm3/dimm_ce_count:1
>  /sys/devices/system/edac/mc/mc0/dimm4/dimm_ce_count:1
>  /sys/devices/system/edac/mc/mc0/dimm6/dimm_ce_count:2
>  /sys/devices/system/edac/mc/mc1/ce_count:4
>  /sys/devices/system/edac/mc/mc1/csrow0/ce_count:1
>  /sys/devices/system/edac/mc/mc1/csrow0/ch0_ce_count:1
>  /sys/devices/system/edac/mc/mc1/csrow3/ce_count:1
>  /sys/devices/system/edac/mc/mc1/csrow3/ch0_ce_count:1
>  /sys/devices/system/edac/mc/mc1/csrow6/ce_count:2
>  /sys/devices/system/edac/mc/mc1/csrow6/ch0_ce_count:2
>  /sys/devices/system/edac/mc/mc1/dimm0/dimm_ce_count:1
>  /sys/devices/system/edac/mc/mc1/dimm3/dimm_ce_count:1
>  /sys/devices/system/edac/mc/mc1/dimm6/dimm_ce_count:2
> 
> 
> v2 updates:
> 
>  * rebased onto bp/for-next (b2572772d13e: EDAC: Make
>    edac_debugfs_create_x*() return void),
> 
>  * added patches to fix grain calculation (put this at the beginning
>    of the series to apply them separately),
> 
>  * modified sysfs init functions based (EDAC, mc: Fix and improve
>    sysfs init functions) on Greg's fixes (f5d59da9663d EDAC/sysfs:
>    Drop device references properly),
> 
>  * removed duplicate code for mem_info_setup*() by moving it to
>    ghes_dimm_info_init(),
> 
>  * fix bisecting of series,
> 
>  * made mem_info static,
> 
>  * renamed function mci_add_dimm_info() to mem_info_prepare_mci(),
> 
>  * added patch to move struct member smbios_handle to struct
>    ghes_dimm_info,
> 
>  * renamed ghes_mem_info.num_per_node[] to
>    ghes_mem_info.dimms_per_node[],
> 
>  * removed unused mem_info.enable_numa,
> 
>  * removed unused mem_info.num_nodes,
> 
>  * fixed dimm counters after sysfs reset_counters.
> 
> 
> Robert Richter (24):
>   EDAC, mc: Fix grain_bits calculation
>   EDAC, ghes: Fix grain calculation
>   EDAC, ghes: Remove pvt->detail_location string
>   EDAC, ghes: Unify trace_mc_event() code with edac_mc driver
>   EDAC, mc: Fix and improve sysfs init functions
>   EDAC: Kill EDAC_DIMM_PTR() macro
>   EDAC: Kill EDAC_DIMM_OFF() macro
>   EDAC: Introduce mci_for_each_dimm() iterator
>   EDAC, mc: Cleanup _edac_mc_free() code
>   EDAC, mc: Remove per layer counters
>   EDAC, mc: Rework edac_raw_mc_handle_error() to use struct dimm_info
>   EDAC, ghes: Use standard kernel macros for page calculations
>   EDAC, ghes: Add support for legacy API counters
>   EDAC, ghes: Rework memory hierarchy detection
>   EDAC, ghes: Extract numa node information for each dimm
>   EDAC, ghes: Moving code around ghes_edac_register()
>   EDAC, ghes: Create one memory controller device per node
>   EDAC, ghes: Fill sysfs with the DMI DIMM label information
>   EDAC, mc: Introduce edac_mc_alloc_by_dimm() for per dimm allocation
>   EDAC, ghes: Identify dimm by node, card, module and handle
>   EDAC, ghes: Enable per-layer reporting based on card/module
>   EDAC, ghes: Move struct member smbios_handle to struct ghes_dimm_info
>   EDAC, Documentation: Describe CPER module definition and DIMM ranks
>   EDAC, ghes: Disable legacy API for ARM64
> 
>  Documentation/admin-guide/ras.rst |  31 +-
>  drivers/edac/edac_mc.c            | 385 ++++++++++---------
>  drivers/edac/edac_mc.h            |  33 +-
>  drivers/edac/edac_mc_sysfs.c      |  95 ++---
>  drivers/edac/ghes_edac.c          | 609 +++++++++++++++++++++++-------
>  drivers/edac/i10nm_base.c         |   3 +-
>  drivers/edac/i3200_edac.c         |   3 +-
>  drivers/edac/i5000_edac.c         |   5 +-
>  drivers/edac/i5100_edac.c         |  14 +-
>  drivers/edac/i5400_edac.c         |   4 +-
>  drivers/edac/i7300_edac.c         |   3 +-
>  drivers/edac/i7core_edac.c        |   3 +-
>  drivers/edac/ie31200_edac.c       |   7 +-
>  drivers/edac/pnd2_edac.c          |   4 +-
>  drivers/edac/sb_edac.c            |   2 +-
>  drivers/edac/skx_base.c           |   3 +-
>  drivers/edac/ti_edac.c            |   2 +-
>  include/linux/edac.h              | 141 ++++---
>  18 files changed, 842 insertions(+), 505 deletions(-)
> 
> -- 
> 2.20.1
> 
