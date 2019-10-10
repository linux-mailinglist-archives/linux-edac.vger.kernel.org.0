Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C645AD27C4
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfJJLIV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 07:08:21 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:47775 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfJJLIU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 07:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570705699; x=1602241699;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=V2ydo28Lc6c9cItVS+fkrIUwgFv/HEZ1xtrOF0Mb1ZI=;
  b=EFItdW2Ru5ZSIZ6EeK8LtEyyS/dzTu4Mvo9BmjjmW3dqnv7fszw61Ap0
   /HNsY+0Eq7Pd78vCYkPv2DZ5/2JEUImxxAFNVUKYzLmpbr8FehITonUcG
   55EmPQctJYgyKxcereFqOJuQ3n7WwMOtApKJhcHDK5mMLhix/Cglt7T8e
   s=;
X-IronPort-AV: E=Sophos;i="5.67,279,1566864000"; 
   d="scan'208";a="427547040"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Oct 2019 11:08:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id A1864A2412;
        Thu, 10 Oct 2019 11:08:15 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:08:15 +0000
Received: from [10.125.238.52] (10.43.161.16) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 11:08:06 +0000
Subject: Re: [PATCH v5 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
To:     Rob Herring <robh@kernel.org>
CC:     <maz@kernel.org>, <mark.rutland@arm.com>, <arnd@arndb.de>,
        <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <paulmck@linux.ibm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
References: <1570452435-8505-1-git-send-email-talel@amazon.com>
 <1570452435-8505-2-git-send-email-talel@amazon.com>
 <20191009232927.GA23987@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <5c3d9e1b-0549-0609-4b4a-5edc312a3873@amazon.com>
Date:   Thu, 10 Oct 2019 14:08:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191009232927.GA23987@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.16]
X-ClientProxiedBy: EX13d09UWA004.ant.amazon.com (10.43.160.158) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thanks for the review

On 10/10/2019 2:29 AM, Rob Herring wrote:
> On Mon, Oct 07, 2019 at 03:47:14PM +0300, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs POS SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   .../bindings/edac/amazon,al-pos-edac.yaml          | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
> Please fix errors with 'make dt_binding_check' and resubmit.
>
> Error: Documentation/devicetree/bindings/edac/amazon,al-pos-edac.example.dts:21.28-29 syntax error
> FATAL ERROR: Unable to parse input tree
>
> Hint: You need an include.


Shall add to v6.

By the way, I was not able to see this error by running 'make 
dt_binding_check', but looking in to 'make dtbs_check' I was.

