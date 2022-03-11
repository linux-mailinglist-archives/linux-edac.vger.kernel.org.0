Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97444D6AE7
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiCKX1k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 18:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCKX1j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 18:27:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2205EBD1;
        Fri, 11 Mar 2022 15:26:35 -0800 (PST)
Received: from zn.tnic (p200300ea9719388a568d7c698b997aed.dip0.t-ipconnect.de [IPv6:2003:ea:9719:388a:568d:7c69:8b99:7aed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D26331EC050D;
        Fri, 11 Mar 2022 22:00:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647032444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JpIq6ekrJpOUTsg6cHFprI2/5RJXASUAuEdVc9D8S9k=;
        b=b9Q5VbeBECyqG+BpOY6zgOn2mC7w664Y24poCqiTNluUNb3+a2IKUBm+6knRfO1Slpoa0N
        mLGklLTHZ577DWjTJYee6rzJcpLDCn9eWlGF74beKl0nHq2e2gRDgvyefvo5XRTRLYW9yV
        LeQlbFPCubLIGJJaDXqLsWUBPcIhZuc=
Date:   Fri, 11 Mar 2022 22:00:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 16/24] EDAC/amd64: Define function to make space for
 CS ID
Message-ID: <Yiu4guP6xPUuSzuz@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-17-yazen.ghannam@amd.com>
 <YgpQLnTd4TyiehS/@zn.tnic>
 <YikpUrojo1cMFfOp@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YikpUrojo1cMFfOp@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 09, 2022 at 10:25:22PM +0000, Yazen Ghannam wrote:
> I guess this could be "addr = func(x, y, addr)", but why not just operate on
> the value directly? There isn't an error condition here that's obvious to me.

Because when you look at the callsite:

	ctx->make_space_for_cs_id(ctx);

and compare it with the version I'm suggesting:

	ctx->ret_addr = ctx->add_coherent_slave_id_slice(ctx);

my version says exactly what it does: it adds the bit slice of CS ID to
ret_addr. You don't even have to look at the function body in order to
know what's going on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
