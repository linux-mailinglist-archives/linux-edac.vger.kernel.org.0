Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243F6283A9
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfEWQbs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 12:31:48 -0400
Received: from foss.arm.com ([217.140.101.70]:50442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbfEWQbs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 12:31:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB96341;
        Thu, 23 May 2019 09:31:47 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 148FF3F5AF;
        Thu, 23 May 2019 09:31:45 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "lewan@microsoft.com" <lewan@microsoft.com>
References: <CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <279a6f66-c889-791b-09b0-9769e5e0aa87@arm.com>
Date:   Thu, 23 May 2019 17:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Lei,

On 16/05/2019 03:35, Lei Wang wrote:
> From: Lei Wang <leiwang_git@outlook.com>
> 
> This is the device tree bindings for new EDAC driver dmc520_edac.c.

> diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> new file mode 100644
> index 0000000..71e7aa3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> @@ -0,0 +1,26 @@
> +* ARM DMC-520 EDAC node
> +

> +Required properties:
> +- compatible		: "brcm,dmc-520", "arm,dmc-520".
> +- reg			: Address range of the DMC-520 registers.
> +- interrupts		: DMC-520 interrupt numbers. The example below specifies
> +			  two interrupt lines for dram_ecc_errc_int and
> +			  dram_ecc_errd_int.
> +- interrupt-config	: This is an array of interrupt masks. For each of the
> +			  above interrupt line, add one interrupt mask element to
> +			  it. That is, there is a 1:1 mapping from each interrupt
> +			  line to an interrupt mask. An interrupt mask can represent
> +			  multiple interrupts being enabled.

Cunning!


> +			  Refer to interrupt_control
> +			  register in DMC-520 TRM for interrupt mapping. In the example
> +			  below, the interrupt configuration enables dram_ecc_errc_int
> +			  and dram_ecc_errd_int. And each interrupt is connected to
> +			  a separate interrupt line.
> +
> +Example:
> +
> +dmc0: dmc@200000 {
> +	compatible = "brcm,dmc-520", "arm,dmc-520";
> +	reg = <0x200000 0x80000>;
> +	interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
> +	interrupt-config = <0x4>, <0x8>;
> +};
> 

For what its worth:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
