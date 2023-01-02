Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2036065B2D7
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjABNnw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 08:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjABNng (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 08:43:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7946554;
        Mon,  2 Jan 2023 05:43:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B27CB1EC050D;
        Mon,  2 Jan 2023 14:43:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672667012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xi36TUgczxJAS3F6aRNBNL+ECxy2O2wuvSvhq0mjhFc=;
        b=cxJvTZ6CumcuczPVlh5cvIluyE4dk0E1EwjC0USdOqvnEfPitNqidvj0Asc2wVlnH5M7Qs
        2foReVviyGVd6t51zFMns0LyCyutuaY4lVJC6G6EdbXQ2fzD+Bf/yuKUA61REa65tzJbGY
        GEIvqLO3uA3m/Ytd00qpx97yLMGjvKE=
Date:   Mon, 2 Jan 2023 14:43:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     krzysztof.kozlowski@linaro.org, talelshenhar@gmail.com,
        shellykz@amazon.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR
 Controller
Message-ID: <Y7LfhB5IrLcFzPOi@zn.tnic>
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 02, 2023 at 02:17:24PM +0200, Shenhar, Talel wrote:
> * We want to introduce driver that reads DDR controller RAS register and
> notify for ECC errors by using EDAC MC API found in drivers/edac.
> * We also want to have a capability to dynamically change DDR refresh rate
> based on thermal values (best to be done in drivers/memory ?).

Is there any particular reason to want to report the errors through EDAC?

Or can't you simply read the RAS register in your memory driver and dump error
info from there so that you have a single driver that does it all?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
