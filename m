Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F299D1F6
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfHZOte (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Aug 2019 10:49:34 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6071 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbfHZOte (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Aug 2019 10:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566830973; x=1598366973;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cV++afZdVCdnVK5vWMAnee3Y5NbvfdxEOLMY1xSyQuY=;
  b=pb7accaBtgIRuxawZzQCai/79IvcvKtrFjHRGE55GL3ui3rUt4/5qtoK
   3NaWSWCfs9oaXplx1eEqCQyNNoN/40hzZR9F+puksbMC0SxY0IF5yeddf
   GoWe1XZqsydcaGT7b0QLdytck/z9l1AN9I/X34LFkF+RLEQnbksegBJuY
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="697550575"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Aug 2019 14:49:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 364B3A2027;
        Mon, 26 Aug 2019 14:49:16 +0000 (UTC)
Received: from EX13D08UEE003.ant.amazon.com (10.43.62.118) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 14:49:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE003.ant.amazon.com (10.43.62.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 14:49:15 +0000
Received: from [10.107.3.18] (10.107.3.18) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 26 Aug 2019 14:49:12 +0000
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1
 EDAC
To:     Rob Herring <robh@kernel.org>
CC:     <mark.rutland@arm.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20190805143911.12185-1-hhhawa@amazon.com>
 <20190805143911.12185-2-hhhawa@amazon.com> <20190821191704.GA32425@bogus>
Message-ID: <1d23d7c5-cd7b-1512-5300-d43e82ba6dc1@amazon.com>
Date:   Mon, 26 Aug 2019 17:49:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821191704.GA32425@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 8/21/2019 10:17 PM, Rob Herring wrote:
> Why is this even in DT? AFAICT, this is all just CortexA57 core features
> (i.e. nothing Amazon specific). The core type and the ECC capabilities
> are discoverable.

Added to the DT in order to easily enable/disable the driver. You are 
correct that they are CortexA57 core features and nothing Amazon 
specific, but it's IMPLEMENTATION DEFINED, meaning that in different 
cortex revisions (e.g. A57) the register bitmap may change. Because of 
that we added an Amazon compatible which corresponds to the specific 
core we are using.

Thanks,
Hanna

> 
> Rob
