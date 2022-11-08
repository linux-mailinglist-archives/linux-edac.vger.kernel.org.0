Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A63621C09
	for <lists+linux-edac@lfdr.de>; Tue,  8 Nov 2022 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiKHSj0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Nov 2022 13:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKHSjN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Nov 2022 13:39:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1A5654B;
        Tue,  8 Nov 2022 10:39:09 -0800 (PST)
Received: from zn.tnic (p200300ea9733e764329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e764:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED7821EC0430;
        Tue,  8 Nov 2022 19:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667932748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8fLhmoHxNKU+a+bc3xohiwQRE4EoG7MAtkbqTpQZLlw=;
        b=mPXbp6FmjW7vXaUgvrmqFNU/7eex8aszg6F8EqeAIN7Fxm7uqSZpr9oT/RQsNKzfXT1yJu
        gfZ8GTIeyksuECZAYikvBRPCJ1T15c8otctpg41kl6K8MkdwNgODuBP+SF0TuobytFnnU/
        vnp4C8FZ4NbYz58keDmRznfRiYdA4KY=
Date:   Tue, 8 Nov 2022 19:39:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Message-ID: <Y2qiRoiYepte/R4W@zn.tnic>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 02, 2022 at 12:36:55PM +0530, Sai Krishna Potthuri wrote:
> Add EDAC support for Xilinx ZynqMP OCM Controller, this driver

So a while ago you said that this driver is for the on chip memory
controller. Is it possible for such a system to have another memory
controller too for which another EDAC driver gets loaded?

Because the EDAC core - at least on x86 - assumes that a single driver
runs on the system and I don't think I've ever had the case where we
need multiple drivers. And in such case to audit it for concurrency
issues.

So I guess the question is, can a system have zynqmp_ocm_edac and say,
synopsys_edac or some other EDAC driver loaded at the same time?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
