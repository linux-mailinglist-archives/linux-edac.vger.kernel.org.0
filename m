Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36266552222
	for <lists+linux-edac@lfdr.de>; Mon, 20 Jun 2022 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiFTQVh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Jun 2022 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiFTQVX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Jun 2022 12:21:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40141A071;
        Mon, 20 Jun 2022 09:21:22 -0700 (PDT)
Received: from zn.tnic (p200300ea974657f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57f0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B55B1EC05ED;
        Mon, 20 Jun 2022 18:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1655742076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T48rGXc2UHAUKkDOY5tz9vpt/ugxavpsm8or1kKDdLs=;
        b=qnidU6MWxcN8zvm5swGUEpplVS2B6i5n6LyV6OlZGNmQYD2JT6ieZnQ0JmTscm0Yummm9Z
        jFJe36mmrDvWlny0QJhDw34bVOgxqLtCHXU5BhiyLllCyCVtrZWtvtqZLKqocfl1lU70Q0
        ETAbyh5EopQbk7pEbNS4FdUXCWVEUGc=
Date:   Mon, 20 Jun 2022 18:21:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 12/18] EDAC/amd64: Add determine_edac_cap() into pvt->ops
Message-ID: <YrCed0NnrVUjKoJh@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-13-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509145534.44912-13-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Back to those...

On Mon, May 09, 2022 at 02:55:28PM +0000, Yazen Ghannam wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> GPU Nodes will have different criteria for checking the EDAC
> capabilities of a controller. A function pointer should be used rather
> than introduce another branching condition.
> 
> Prepare for this by adding determine_edac_cap() to pvt->ops and set it
> as needed based on currently supported systems.
> 
> Use a "umc" prefix for modern systems, since these use Unified Memory
> Controllers (UMCs).
> 
> Use a "dct" prefix for newly-defined legacy functions, since these
> systems use DRAM Controllers (DCTs).

Please refrain from adding those boilerplates to each commit message. Do
it once for the first patch and then no need anymore. It is clear what's
going on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
