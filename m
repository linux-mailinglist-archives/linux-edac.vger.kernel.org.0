Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6379528465
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfEWQ6q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 12:58:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50982 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQ6q (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 12:58:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBD31374;
        Thu, 23 May 2019 09:58:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A693F5AF;
        Thu, 23 May 2019 09:58:44 -0700 (PDT)
Date:   Thu, 23 May 2019 17:58:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "lewan@microsoft.com" <lewan@microsoft.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20190523165841.GD7523@lakrids.cambridge.arm.com>
References: <CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 16, 2019 at 02:35:47AM +0000, Lei Wang wrote:
> From: Lei Wang <leiwang_git@outlook.com>
> 
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> ---
>  .../devicetree/bindings/edac/arm-dmc520.txt        | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
> 
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
> +			  multiple interrupts being enabled. Refer to interrupt_control
> +			  register in DMC-520 TRM for interrupt mapping. In the example
> +			  below, the interrupt configuration enables dram_ecc_errc_int
> +			  and dram_ecc_errd_int. And each interrupt is connected to
> +			  a separate interrupt line.

Generally we use interrupt-names to distinguish interrupts.

Do you really have arbitary subsets of lines muxed together?

Thanks,
Mark.

> +
> +Example:
> +
> +dmc0: dmc@200000 {
> +	compatible = "brcm,dmc-520", "arm,dmc-520";
> +	reg = <0x200000 0x80000>;
> +	interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
> +	interrupt-config = <0x4>, <0x8>;
> +};
> -- 
> 2.7.4
> 
