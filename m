Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696A2702FB0
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjEOO1J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 10:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjEOO1I (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 10:27:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E035135
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 07:27:05 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B42A1EC04CC;
        Mon, 15 May 2023 16:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684160824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W6igT3XdnnMKUpDs8CM7cjJEWisjyfHumfoyBaPCJzc=;
        b=O2HXhq+lrB1JbAkASDFE1G1JoMMBVEC3kWMy3ODIDdASOORakEyOrHc1Llr2/3vvQ1V7RP
        V9TnJ/qyYmgZOcTJ75BeSYlWsT8s/UmNfvqG4k6/tdpDKRb+lVEBYisceEgPRfvmCjA9jx
        s7EqkhN6bmtpFldxaTpbblIY6tThtms=
Date:   Mon, 15 May 2023 16:27:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hristo Venev <hristo@venev.name>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Add support for ECC on family 19h model
 60h-6Fh
Message-ID: <20230515142700.GEZGJBND0RQoe8AbpL@fat_crate.local>
References: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
 <20230511174506.875153-1-hristo@venev.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230511174506.875153-1-hristo@venev.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 11, 2023 at 08:45:06PM +0300, Hristo Venev wrote:
> do you think you could look into it?

Yeah, that's being worked on but it'll take a while longer.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
