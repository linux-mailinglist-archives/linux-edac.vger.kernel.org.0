Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC85621CAE
	for <lists+linux-edac@lfdr.de>; Tue,  8 Nov 2022 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKHTID (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Nov 2022 14:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKHTIC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Nov 2022 14:08:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04B8C598;
        Tue,  8 Nov 2022 11:08:01 -0800 (PST)
Received: from zn.tnic (p200300ea9733e764329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e764:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 617CB1EC0430;
        Tue,  8 Nov 2022 20:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667934480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lssjc5TnqqSvaM+L8ZN7oXHyNntVLTRDNG/h5HCVRG4=;
        b=TCW+thf3GAae5pyCrOoT6jIb8UU9CIRtNU8CY8V/TOovkaqcbhjnKzHBdaGUDWDcRcSOy1
        OnSLZ5d707sKyxVyUgUGxhRqdWcoDG3Uw3sIlQuth+vWQN+m2Pw/rxJYdTrDlQZ1SmtrFs
        4+HEb9xvYDbPxDXkXjOla3jBKiIe8Jk=
Date:   Tue, 8 Nov 2022 20:07:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     linux-edac@vger.kernel.org, git@amd.com,
        devicetree@vger.kernel.org, michal.simek@xilinx.com,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 0/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Message-ID: <Y2qpC6sk+1Wpde9h@zn.tnic>
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 07, 2022 at 11:54:11AM +0530, Shubhrajyoti Datta wrote:
> 
> The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/4X
> memory interfaces. It has four programmable NoC interface ports and is designed
> to handle multiple streams of traffic.
> 
> Optional external interface reliability include ECC error detection/correction
> and command address parity.
> 
> Adding edac support for DDR Memory controller.

Same question as in

https://lore.kernel.org/r/Y2qiRoiYepte/R4W@zn.tnic

How many memory controllers are there in Xilinx boards and how many EDAC
drivers can potentially be needed to run in parallel?

Also, this is an integrated memory controller, ZynqMP OCM is a on-chip
controller. Can we have a single xilinx_edac driver which contains
support for both memory controller types or are they completely
different?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
