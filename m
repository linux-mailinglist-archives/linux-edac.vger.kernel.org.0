Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2408D1705AE
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBZRMj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Feb 2020 12:12:39 -0500
Received: from foss.arm.com ([217.140.110.172]:39386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgBZRMi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Feb 2020 12:12:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5061330E;
        Wed, 26 Feb 2020 09:12:38 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218623F881;
        Wed, 26 Feb 2020 09:12:34 -0800 (PST)
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
 <312fc8b8-7019-0c74-6a92-c6740cab5dad@arm.com>
 <3c3b1d8107a26bbbf8daca3a6c43caca@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <f97426fb-3181-5fe9-43ac-be585814ef6e@arm.com>
Date:   Wed, 26 Feb 2020 17:12:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3c3b1d8107a26bbbf8daca3a6c43caca@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sai,

On 24/01/2020 14:21, Sai Prakash Ranjan wrote:
> On 2020-01-16 00:18, James Morse wrote:
>> On 05/12/2019 09:53, Sai Prakash Ranjan wrote:
>>> This adds DT bindings for Kryo EDAC implemented with RAS
>>> extensions on KRYO{3,4}XX CPU cores for reporting of cache
>>> errors.

>>> diff --git a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>>> b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>>> new file mode 100644
>>> index 000000000000..1a39429a73b4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml

>> There is also an MMIO interface which needs a base address, along with
>> the index and
>> ranges. (which may be different). The same component may use both the
>> system register and the MMIO interface.

> I have some doubts here, Where do I get this info? Will this be implementation specific?

It will be implementation specific. The ACPI spec folk have gathered some of the range of
ways people are putting this together. We should take that into account with the binding,
otherwise we end up with a 'v1' and 'v2' of the binding and have to support both.


There is a 'Beta 2' of that ACPI document. It should appear on the website at some point.
Qualcomm should have this somewhere, its called 'DEN0085_RAS_ACPI_1.0_RELEASE_BETA2.pdf.


Thanks,

James
