Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EA4BFE26
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiBVQK4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 11:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBVQKz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 11:10:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113B165C10;
        Tue, 22 Feb 2022 08:10:30 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B66521EC0529;
        Tue, 22 Feb 2022 17:10:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645546224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=paBaplTKC9zVh2D5mX/2U4Kqmpe5+qxfcuoi6G6m2rs=;
        b=pmo4S/oegw3h1fqSOZ652r7innZImkVbw5Z3ot7pOtGLtXv2Kz/uQG3M3/ymUQOO/A3rkO
        X/9KlpjgQYYjdRRzA76OQU6jrdeP3xWrzrDuCERFp/BSaX9GoDlYofTKisprPZD/F28FPw
        oyiKlpQ6X2ZTypJNHMM/C22AQQ1mwo4=
Date:   Tue, 22 Feb 2022 17:10:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tony.luck@intel.com, yazen.ghannam@amd.com,
        Smita.KoralahalliChannabasappa@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Simplify CPU vendor checks for AMD/Hygon and
 Intel/Zhaoxin
Message-ID: <YhUK87H4PQ22rpLw@zn.tnic>
References: <20220222155857.276286-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222155857.276286-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 22, 2022 at 09:58:58AM -0600, Carlos Bilbao wrote:
> In a number of places across the MCE subsystem we check if we are running
> an x86 processor from AMD/Hygon or Intel/Zhaoxin vendors. Simplify these
> checks with two mce_flags updated at CPU MCE initialization.

... and what's the point of this silliness?

Btw, you don't have to send it to my *two* email addresses - one is
enough. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
