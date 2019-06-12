Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD1425F9
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407713AbfFLMfo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 08:35:44 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:42821 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407663AbfFLMfo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Jun 2019 08:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560342943; x=1591878943;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VFn/gI6zgNUuVhHVrpgAggjKM4seBCL+904wneHHRAg=;
  b=ver4vcTBWLqgucpl4hGD6Omd/SYV7YzjgxmbCXwD4nID0STSHE5ZOat+
   3ga/e671+3UoOeOLrxAQKuV9aYuEqndtgqOenJXbmE1WJztgYYAqdfGsc
   m/sm/68Gz7sw+dn4TN5tpVV2BKTBwzM7uzRB5GUs/L1FKRzv9wB1+ebgi
   I=;
X-IronPort-AV: E=Sophos;i="5.62,365,1554768000"; 
   d="scan'208";a="809976184"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 12 Jun 2019 12:35:40 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id E7ECDA1B8C;
        Wed, 12 Jun 2019 12:35:36 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 12:35:36 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 12:35:35 +0000
Received: from [10.107.3.21] (10.107.3.21) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Wed, 12 Jun 2019 12:35:32 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
References: <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
 <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
 <20190611115651.GD31772@zn.tnic>
 <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
 <20190612034813.GA32652@zn.tnic>
 <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
 <20190612074242.53a4cf56@coco.lan> <20190612110039.GH32652@zn.tnic>
 <20190612084213.4fb9e054@coco.lan>
 <7705227ea831793cc9e45af32e0da8f5547cb14d.camel@kernel.crashing.org>
 <20190612122504.GI32652@zn.tnic>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <6911a79a-bcd7-03e1-1c90-2adb88aaa1db@amazon.com>
Date:   Wed, 12 Jun 2019 15:35:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612122504.GI32652@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

> 
> Yap, I think we're in agreement here. I believe the important question
> is whether you need to get error information from multiple sources
> together in order to do proper recovery or doing it per error source
> suffices.
> 
> And I think the actual use cases could/should dictate our
> drivers/orchestrators design.
> 
> Thus my question how you guys are planning on tying all that error info
> the drivers report, into the whole system design?
We have daemon script that collects correctable/uncorrectable errors 
from EDAC sysfs and reports to Amazon service that allow us to take 
action on specific error thresholds.

Thanks,
Hanna
> 
