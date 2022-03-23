Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82A4E5797
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 18:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiCWRgX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiCWRgV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 13:36:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DBF44A2D
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 10:34:50 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 810961EC0537;
        Wed, 23 Mar 2022 18:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648056885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sfbR0Soh68TUYijdA/+0QkJKYVaQ1ddLqZqmPkKqxAI=;
        b=ehq1BYR0JjZuLvvWaJylDNE61BuT7NSuPCSwizK7d12diSnYwLGPPaeqjMaimB+NQ+gfpw
        8alFTVh1fHFYtyHa/XNzeSPU5BqgwGpns4NDCu/9t4n8WKtEGRU3iSVJprRaK2OmQFxx3J
        hEc6RUle8pXo6Y+bOP9ixzeRheg3i4g=
Date:   Wed, 23 Mar 2022 18:34:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 02/14] EDAC/amd64: Add get_base_mask() into pvt->ops
Message-ID: <YjtaNYFiyfARKZ0a@zn.tnic>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-3-nchatrad@amd.com>
 <YjtZ3h7jd9gu1Vya@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjtZ3h7jd9gu1Vya@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 23, 2022 at 05:33:18PM +0000, Yazen Ghannam wrote:
> The commit message should include why the change is needed and not just what
> the change is. A few of my patches have similar feedback, so it's fresh in my
> mind. :)

Good. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
