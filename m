Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85EA6240B9
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 12:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiKJLHa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKJLHZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 06:07:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4466F348;
        Thu, 10 Nov 2022 03:07:22 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E662B1EC0723;
        Thu, 10 Nov 2022 12:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668078441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=48k0S2al7uQS4UVvtuNjthpDtQOt/nuPQzF+86DA2Ps=;
        b=DFoOaUXj/CbbgpHanTnyKZlUJJAoa4nQCXQWFsy6Q9xDvGTet9bHtRLJ1XDPRLrgokw38/
        34PVWjHWG7JqD6gPs5acjn+6mt08AiN/6RVtLESrmhuaKsWbpGD0TVXWJLUHYV2Q4XdWZI
        p/Q54mrcsxw9sYLA/AkSRLtLZa1KRa0=
Date:   Thu, 10 Nov 2022 12:07:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-edac@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        devicetree@vger.kernel.org, tony.luck@intel.com,
        mchehab@kernel.org, michal.simek@xilinx.com, git@amd.com,
        robh+dt@kernel.org, james.morse@arm.com, rric@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: edac: Add bindings for
 Xilinx Versal EDAC for DDRMC
Message-ID: <Y2zbaI+2Thq0t6dv@zn.tnic>
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
 <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
 <166807145377.16822.15787804198836912482.b4-ty@linaro.org>
 <Y2zL3OXBNfR/VNPK@zn.tnic>
 <207ae5bd-dbc2-9c4b-2acc-bda480da711e@linaro.org>
 <Y2zYqetP6IhG01Bg@zn.tnic>
 <490d26ce-a09c-db16-93b1-8f468a5c3f87@linaro.org>
 <Y2zZj69EEZlqRfBd@zn.tnic>
 <2d1cddd6-448b-4a3c-72e1-2ce3cfb44268@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d1cddd6-448b-4a3c-72e1-2ce3cfb44268@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 10, 2022 at 12:00:34PM +0100, Krzysztof Kozlowski wrote:
> I already dropped them from my tree, so let's wait for respin and then
> you can take entire set.

Or that. Ok, will wait for your Reviewed-by tag then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
