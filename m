Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF636DD4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 09:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFFHxx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 03:53:53 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:43781 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHxw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jun 2019 03:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559807632; x=1591343632;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4rKMDgk0idWhZbYe/MH2P9996yrzfb/TgPhooH3LB20=;
  b=A4Tz+HeUgJv+KhXGNR8ov3D9CQ6eB32ywTpXglB2b28lRirIIKm9ImXv
   jbuhUf6jZ+hOe03o1tKfzletybDDgEL0DbJPB/68Im6kcG6bBgDUjfUwy
   sr4aE32vZpViHiflo1WsSLiT9O62N1DiqMEgNQAgbwMOPfHMv1uxIBsui
   A=;
X-IronPort-AV: E=Sophos;i="5.60,558,1549929600"; 
   d="scan'208";a="399612691"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-3714e498.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Jun 2019 07:53:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-3714e498.us-west-2.amazon.com (Postfix) with ESMTPS id 0F26AA27E5;
        Thu,  6 Jun 2019 07:53:49 +0000 (UTC)
Received: from EX13D21UWB001.ant.amazon.com (10.43.161.108) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 07:53:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D21UWB001.ant.amazon.com (10.43.161.108) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 07:53:48 +0000
Received: from [10.107.3.17] (10.107.3.17) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 6 Jun 2019 07:53:43 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     Borislav Petkov <bp@alien8.de>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "james.morse@arm.com" <james.morse@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
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
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
Date:   Thu, 6 Jun 2019 10:53:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531051400.GA2275@cz.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 5/31/2019 8:14 AM, Borislav Petkov wrote:
> On Fri, May 31, 2019 at 01:15:33AM +0000, Herrenschmidt, Benjamin wrote:
>> This isn't terribly helpful, there's nothing telling anybody which of
>> those files corresponds to an ARM SoC :-)
> 
> drivers/edac/altera_edac.c is one example.
> 
> Also, James and I have a small writeup on how an arm driver should look
> like, we just need to polish it up and post it.
> 
> James?
> 
>> That said ...
>>
>> You really want a single EDAC driver that contains all the stuff for
>> the caches, the memory controller, etc... ?
> 
> Yap.

Disagree. The various drivers don't depend on each other.
I think we should keep the drivers separated as they are distinct and 
independent IP blocks.

> 
