Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F216CCAD5
	for <lists+linux-edac@lfdr.de>; Tue, 28 Mar 2023 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC1TkR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Mar 2023 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1TkQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Mar 2023 15:40:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262A9F;
        Tue, 28 Mar 2023 12:40:15 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7008D1EC0666;
        Tue, 28 Mar 2023 21:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680032413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYKENnuFViqV4uuxjzgDCIssTeKf6ZqsJHXXCu2T17o=;
        b=qXywtdFq7bOfFJYI+1Zc92M3qiiwPv6xstW3hIcOUiuExv5/RlR7FP9fzydQTFAq92kvQ0
        Pv8RzC10Wi+8f702wg0LIEEYe87VITooUzBOvMA05QtvsB+txxa/YmrO0hL9ruWPl+uohc
        +0Tp8GqD/E1xrjjDzky3wBgUEERXVmo=
Date:   Tue, 28 Mar 2023 21:40:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd81*1: Remove "\n" from MODULE_AUTHOR
Message-ID: <20230328193958.GGZCNCjqYzUX+wypTw@fat_crate.local>
References: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
 <20230319192011.GEZBdga+n600nFi/tA@fat_crate.local>
 <ZCM/bUZqQ+hbvZrG@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCM/bUZqQ+hbvZrG@probook>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 28, 2023 at 09:26:37PM +0200, Jonathan Neuschäfer wrote:
> I might fix the above if/when I get around to it, but there's currently
> no guarantee of that.

No need, already took care of them all, while at it.

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
