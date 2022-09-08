Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51E5B1738
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiIHIgh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 04:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIHIge (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 04:36:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC2DFF6A;
        Thu,  8 Sep 2022 01:36:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-046-114-005-040.46.114.pool.telefonica.de [46.114.5.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDA8A1EC0688;
        Thu,  8 Sep 2022 10:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662626187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XuHu7ijixnDVcJyxwfF2tvQPIz8t5KmGFJYE6RW2grE=;
        b=l/ghC8xYF6HL+YnZsbaJsn5IFWs6Ve48MGemBwbO1llVjAOqrTkilywAXF6px9litEbnoX
        AkvWkf8PsfSgDmMOs4E4bNW23Z36xAZfv8oN/nJcRSJEoYrzj8Amv5uE/FZAvbXEqZyJpu
        B2n6GIoDyMj34ita6V0RTeVS/LHEafY=
Date:   Thu, 08 Sep 2022 08:36:23 +0000
From:   Boris Petkov <bp@alien8.de>
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Subject: RE: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
In-Reply-To: <BY5PR12MB4258C4746631BBD6A7B388D6DB409@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220907111531.703-1-sai.krishna.potthuri@amd.com> <20220907111531.703-3-sai.krishna.potthuri@amd.com> <YxikJCguJWunfh6x@nazgul.tnic> <BY5PR12MB4258C4746631BBD6A7B388D6DB409@BY5PR12MB4258.namprd12.prod.outlook.com>
Message-ID: <E7324951-0608-432F-8E9C-6C08DA64838D@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On September 8, 2022 5:39:56 AM UTC, "Potthuri, Sai Krishna" <sai=2Ekrishna=
=2Epotthuri@amd=2Ecom> wrote:
>Synopsys EDAC driver is targeted for DDR Memory Controller and this drive=
r
>is for OCM (On Chip Memory) Controller, both are different hardware contr=
ollers=2E

It would be helpful if the driver help text explained a bit more what hw t=
his driver is for=2E=2E=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
