Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409414BFCBB
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiBVPft (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 10:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiBVPfr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 10:35:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96333163076;
        Tue, 22 Feb 2022 07:35:16 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA4A61EC053F;
        Tue, 22 Feb 2022 16:35:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645544111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=29thYoEkHTABKeYQlaez4oN7wM6QEU4xg+bNgG5X1b8=;
        b=GMoFCKS4OD0L1001W+QSMFJFHqKMcZEoqAaXrQ0Y/xZJaS8vNUiBDKRmY7bt+XxVBaM+d+
        JPuOLRVqztkI3cAxg9mncSKyrFwJPrH8FaL6gj1mAQYyPPYFJZFEI7xVzp29QXWeKArufE
        JDydMRmHqriYjErKPix5UX/fYsQYBIk=
Date:   Tue, 22 Feb 2022 16:35:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 1/4] x86/mce: Define function to extract ErrorAddr
 from MCA_ADDR
Message-ID: <YhUCsT/WQIrFi94R@zn.tnic>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211223442.254489-2-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 04:34:39PM -0600, Smita Koralahalli wrote:
> Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
> will be further refactored in the next patch.

The concept of "next patch" can mean different commits in git so pls
reword your commit message to be void of the patch linearity concept.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
