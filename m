Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC9328FE
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2019 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfFCG5E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jun 2019 02:57:04 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56410 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFCG5E (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jun 2019 02:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559545022; x=1591081022;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=28ubXn7tIxBtQaVuAwhyLsuJAMZSspzvIGvKhunz4Ug=;
  b=LDZ3aPZPSYJn7p5wjgCoYuxgzyYs9SUDXLoXceSaYUdDlWrBCtcsNvlK
   BkOZi/kV03VE4hD0M00ql51YzMlvSz7KMPdNAT38RdmCFsVePQi0e6rB/
   rfTrCH1DYnfhtRZC/G4R22dvzi8Dp/eb0R3R87s6oSMnhZO9a1XfgQkOT
   8=;
X-IronPort-AV: E=Sophos;i="5.60,545,1549929600"; 
   d="scan'208";a="404727797"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Jun 2019 06:56:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 582BDA22F8;
        Mon,  3 Jun 2019 06:56:56 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 3 Jun 2019 06:56:56 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 3 Jun 2019 06:56:55 +0000
Received: from [10.95.119.163] (10.95.119.163) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 3 Jun 2019 06:56:50 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <c608e269-e409-cd2b-d421-f185a706bbc5@amazon.com>
Date:   Mon, 3 Jun 2019 09:56:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 5/31/2019 4:15 AM, Herrenschmidt, Benjamin wrote:
> On Thu, 2019-05-30 at 11:19 -0700, Boris Petkov wrote:
>> On May 30, 2019 3:15:29 AM PDT, Hanna Hawa <hhhawa@amazon.com> wrote:
>>> Add support for error detection and correction for Amazon's
>>> Annapurna
>>> Labs SoCs for L1/L2 caches.
>>
>>
>> So this should be a driver for the whole annapurna platform and not
>> only about the RAS functionality in an IP like the caches. See other
>> ARM EDAC drivers in drivers/edac/ for an example.
> 
> This isn't terribly helpful, there's nothing telling anybody which of
> those files corresponds to an ARM SoC :-)
> 
> That said ...
> 
> You really want a single EDAC driver that contains all the stuff for
> the caches, the memory controller, etc... ?
> 
> The idea here was to separate the core L1/L2 EDAC from the memory
> controller EDAC I think ... Roben, Hanna, can you describe the long run
> strategy here ?
Correct our target to separate the L1/L2 EDAC from mc, and to maintain 
both in separate drivers.

Thanks,
Hanna
> 
> Cheers,
> Ben.
> 
