Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740BDE2C04
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfJXIXh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 04:23:37 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:37317 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfJXIXg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 04:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571905416; x=1603441416;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gV1uCKgOFL33Nz6B+2EEkpVP1jfS42r2O4AG2rmABoo=;
  b=rJQOBe1uHRWLXH892iKAnVneRPZFrn0XoyW2lsie8JHkV8Nzgy1OCF4t
   JgSTdwAIQJZVXJeW/COgQlG1iNn2nsazIdHJnt8RczG/urb4k0nHIIn7I
   eMiKJfC4O10vXVCLaef6aoMK8W+Bn9pC2LbqpdOQGOv8dJr11woMyMEWp
   g=;
IronPort-SDR: 4Oo6PCDFMFRVX1TQT8chabGriYeL4cxGzLv9wCl+1ri5zi3RrX89uzqvinHKz+MhCpBecoc92c
 CIBEyg1J3ADw==
X-IronPort-AV: E=Sophos;i="5.68,224,1569283200"; 
   d="scan'208";a="109256"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 24 Oct 2019 08:23:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id E0F46221844;
        Thu, 24 Oct 2019 08:23:32 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 08:23:32 +0000
Received: from [10.125.238.52] (10.43.160.8) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Oct
 2019 08:23:22 +0000
Subject: Re: [PATCH v6 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <paulmck@linux.ibm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <amirkl@amazon.com>, <barakw@amazon.com>
References: <1570707681-865-1-git-send-email-talel@amazon.com>
 <1570707681-865-2-git-send-email-talel@amazon.com>
 <20191011134223.GA11275@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <46b8eebd-5f18-d5ab-a9a5-aa0edd4bcd48@amazon.com>
Date:   Thu, 24 Oct 2019 11:23:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011134223.GA11275@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.8]
X-ClientProxiedBy: EX13D17UWC002.ant.amazon.com (10.43.162.61) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 10/11/2019 4:42 PM, Rob Herring wrote:
> On Thu, 10 Oct 2019 14:41:20 +0300, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs POS SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   .../bindings/edac/amazon,al-pos-edac.yaml          | 41 ++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
>>
> Reviewed-by: Rob Herring <robh@kernel.org>


Thanks Rob, shall add your reviewed-by with a minor fix, add "-only" to 
the GPL.

