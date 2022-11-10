Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0B62408B
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKJK7b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 05:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKJK7a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 05:59:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986402BED;
        Thu, 10 Nov 2022 02:59:29 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D9BC1EC071E;
        Thu, 10 Nov 2022 11:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668077968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FvIaUY6XwmxY+RNNGNxD4DR8TQ6/T13ShgSzWyuIxLg=;
        b=Uu6hk/fFpxp7xS4Sw9p6xTseSXiUikiy9YdEcgBriklpGq3dArxEdyiThsP2ryP2mHPwuY
        jQQyAmKARrneHe7sg00rpyxXxg2oyysc8hEC19V3CpHNJNIojWu1gPW842t/LJOoo6N/Y6
        mPjEdwNN2HbFxeMknlhY2IWKWYrMIqc=
Date:   Thu, 10 Nov 2022 11:59:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-edac@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        devicetree@vger.kernel.org, tony.luck@intel.com,
        mchehab@kernel.org, michal.simek@xilinx.com, git@amd.com,
        robh+dt@kernel.org, james.morse@arm.com, rric@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: edac: Add bindings for
 Xilinx Versal EDAC for DDRMC
Message-ID: <Y2zZj69EEZlqRfBd@zn.tnic>
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
 <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
 <166807145377.16822.15787804198836912482.b4-ty@linaro.org>
 <Y2zL3OXBNfR/VNPK@zn.tnic>
 <207ae5bd-dbc2-9c4b-2acc-bda480da711e@linaro.org>
 <Y2zYqetP6IhG01Bg@zn.tnic>
 <490d26ce-a09c-db16-93b1-8f468a5c3f87@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <490d26ce-a09c-db16-93b1-8f468a5c3f87@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 10, 2022 at 11:57:11AM +0100, Krzysztof Kozlowski wrote:
> I don't anticipate more work for current cycle... but I also did not
> anticipate such in other occasions (e.g. recently Tegra binding
> headers), so my anticipation is not accurate. :)

Ok, let's try them your way - you take care of the dtree patches pls and
I do the EDAC ones and then we'll see where this goes.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
