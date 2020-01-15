Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8BD13CC7E
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAOSsG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 13:48:06 -0500
Received: from foss.arm.com ([217.140.110.172]:41270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgAOSsG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 13:48:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F30C328;
        Wed, 15 Jan 2020 10:48:05 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A8D03F6C4;
        Wed, 15 Jan 2020 10:48:02 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org, baicar@os.amperecomputing.com
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <312fc8b8-7019-0c74-6a92-c6740cab5dad@arm.com>
Date:   Wed, 15 Jan 2020 18:48:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sai,

(CC: +Tyler)

On 05/12/2019 09:53, Sai Prakash Ranjan wrote:
> This adds DT bindings for Kryo EDAC implemented with RAS
> extensions on KRYO{3,4}XX CPU cores for reporting of cache
> errors.

KRYO{3,4}XX isn't the only SoC with the RAS extensions. The DT needs to convey the range
of ways this armv8 RAS extensions stuff can be wired up.

The folk who look after the ACPI specs have made a start:
https://static.docs.arm.com/den0085/a/DEN0085_RAS_ACPI_1.0_BETA_1.pdf

(I suspect that isn't the latest version, I'll try and find out)

I'd like the ACPI table and DT to convey the same information so that we don't need to
convert or infer things in the driver. If something is missing, we should get it added!


> diff --git a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> new file mode 100644
> index 000000000000..1a39429a73b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/qcom-kryo-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kryo Error Detection and Correction(EDAC)
> +
> +maintainers:
> +  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +
> +description: |
> +  Kryo EDAC is defined to describe on-chip error detection and correction
> +  for the Kryo CPU cores which implement RAS extensions.

Please don't make this Kryo specific, otherwise this binding becomes an extra thing we
need to support with a 'v8.2 RAS' driver.

What I'd like is a single 'armv82_ras' edac driver that handles faults and errors reported
by interrupts, and interacts with the arch code's handling of 'external aborts'. This
should work for all platforms using v8.2 RAS and later.


> +  It will report
> +  all Single Bit Errors and Double Bit Errors found in L1/L2 caches in
> +  in two registers ERXSTATUS_EL1 and ERXMISC0_EL1. L3-SCU cache errors
> +  are reported in ERR1STATUS and ERR1MISC0 registers.
> +    ERXSTATUS_EL1 - Selected Error Record Primary Status Register, EL1
> +    ERXMISC0_EL1 - Selected Error Record Miscellaneous Register 0, EL1
> +    ERR1STATUS - Error Record Primary Status Register
> +    ERR1MISC0 - Error Record Miscellaneous Register 0
> +  Current implementation of Kryo ECC(Error Correcting Code) mechanism is
> +  based on interrupts.

Your SoC picked the system registers as the interface to these component's registers.
The binding would need to specify which index the 'l1-l2' records start at, and how many
there are. The same for the 'l3-scu'. You can't hard code these, they are different on
other platforms.

There is also an MMIO interface which needs a base address, along with the index and
ranges. (which may be different). The same component may use both the system register and
the MMIO interface.

This stuff is likely to vary on big/little systems, so you need a way of describing which
CPUs the settings refer to. This probably isn't something the ACPI tables capture as ACPI
machines are typically homogenous.


Thanks,

James
