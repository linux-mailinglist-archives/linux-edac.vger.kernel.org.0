Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916775265EF
	for <lists+linux-edac@lfdr.de>; Fri, 13 May 2022 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381919AbiEMPVr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 May 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381937AbiEMPVn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 May 2022 11:21:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC204674C7;
        Fri, 13 May 2022 08:21:38 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 670591EC0722;
        Fri, 13 May 2022 17:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652455292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=57yrkf2Wx97u010Gsq5SOKg6z3QHXYIFsK4X1Q1PjQE=;
        b=A6xL30SZ1SBHRBSM6v3TAZKLJu0DcSj0KVt/bjqsGWd9dgVPI6TVoQu2O+YeY+vtqmjm2/
        uqwtbcZ0ledhD7U8S8xGaz4behhU4+7eodX9upN+fujBveEO0qKCYZ+VGthewwkPG4f7hU
        oUvUanUyXYcYD2/DYpbeKNFKJ0Fr51g=
Date:   Fri, 13 May 2022 17:21:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 05/18] EDAC/amd64: Merge struct amd64_family_type into
 struct amd64_pvt
Message-ID: <Yn53e7RZGBJ7yL76@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-6-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509145534.44912-6-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 09, 2022 at 02:55:21PM +0000, Yazen Ghannam wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Future AMD systems will support heterogeneous "AMD Node" types, e.g.
> CPU+GPU. Therefore, a global "family type" shared across all "AMD Nodes"
> is no longer appropriate.
> 
> Move struct low_ops routines and members of struct amd64_family_type
> to struct amd64_pvt.
> 
> Currently, there are many code branches that split between "modern" and
> "legacy" systems. Another code branch will be needed in order to cover
> "GPU" cases. However, rather than introduce another branching case in
> multiple functions, the current branching code should be switched to a
> set of function pointers. This change makes the code more readable and
> simplifies adding support for new families/models.
> 
> In order to reuse code, define two sets of function pointers. Use one
> for modern systems (Family 17h and later). This will not change between
> current CPU families. Use another set of function pointers for legacy
> systems (before Family 17h). Use the Family 16h versions as default
> for the legacy ops since these are the latest, and adjust the function
> pointers as needed for older families.
> 
> Rename the Family 17h functions to use a "umc" prefix. This is to
> indicate that the functions apply to all modern CPU familes (17h, 18h,

Unknown word [familes] in commit message.
Suggestions: ['families',

> and 19h) which all have Unified Memory Controllers (UMCs).
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> [Rebased/reworked patch and reworded commit message]
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 353 +++++++++++++-------------------------
>  drivers/edac/amd64_edac.h |  66 +++----
>  2 files changed, 140 insertions(+), 279 deletions(-)

That diffstat looks good.

And it simplifies and streamlines the code real nicely.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
