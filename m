Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC36C6609
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 12:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCWLCE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 07:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCWLCD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 07:02:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428C20A3C;
        Thu, 23 Mar 2023 04:01:56 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2D261EC069A;
        Thu, 23 Mar 2023 12:01:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679569315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uI32fCQIg/m5yksAlcb/cw4LvvtbeQSpVHAE2CDs8Rc=;
        b=O7hjss2rpyf8N8/rMK7i6AlJXB3Nxc5c0QSXJCql+cq34/ALFmdF0dago77lcXO+tHdsE5
        gHSAuY2UlKzKrN+h8Aba8sQmEfSWfBqlYna4QYWgTLNUfAiSHSyX8AsxwKH4mfNqD5d8wr
        EKn1lFwgr1Gl7QquWh8wuZ/teMWNwwU=
Date:   Thu, 23 Mar 2023 12:01:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 00/22] AMD64 EDAC Cleanup and Refactor
Message-ID: <20230323110150.GCZBwxnh/ekDGPHGXR@fat_crate.local>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 27, 2023 at 05:03:57PM +0000, Yazen Ghannam wrote:
> Muralidhara M K (11):
>   EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
>   EDAC/amd64: Split prep_chip_selects() into dct/umc functions
>   EDAC/amd64: Split read_base_mask() into dct/umc functions
>   EDAC/amd64: Split determine_memory_type() into dct/umc functions
>   EDAC/amd64: Split read_mc_regs() into dct/umc functions
>   EDAC/amd64: Split ecc_enabled() into dct/umc functions
>   EDAC/amd64: Split setup_mci_misc_attrs() into dct/umc functions
>   EDAC/amd64: Split determine_edac_cap() into dct/umc functions
>   EDAC/amd64: Split init_csrows() into dct/umc functions
>   EDAC/amd64: Split dump_misc_regs() into dct/umc functions
>   EDAC/amd64: Add get_err_info() to pvt->ops
> 
> Yazen Ghannam (11):
>   EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
>   EDAC/amd64: Remove scrub rate control for Family 17h and later
>   EDAC/amd64: Remove PCI Function 6
>   EDAC/amd64: Remove PCI Function 0
>   EDAC/amd64: Remove early_channel_count()
>   EDAC/amd64: Rename debug_display_dimm_sizes()
>   EDAC/amd64: Split get_csrow_nr_pages() into dct/umc functions
>   EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
>   EDAC/amd64: Don't find ECC symbol size for Family 17h and later
>   EDAC/amd64: Rework hw_info_{get,put}
>   EDAC/amd64: Rename f17h_determine_edac_ctl_cap()
> 
>  drivers/edac/amd64_edac.c | 1221 ++++++++++++++-----------------------
>  drivers/edac/amd64_edac.h |   89 +--
>  2 files changed, 483 insertions(+), 827 deletions(-)

All small issues fixed up and applied.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
