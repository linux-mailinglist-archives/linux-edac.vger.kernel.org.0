Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6077ED6
	for <lists+linux-edac@lfdr.de>; Sun, 28 Jul 2019 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfG1Jep (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 28 Jul 2019 05:34:45 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:23333 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfG1Jep (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 28 Jul 2019 05:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564306484; x=1595842484;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HBEj87FM8520lmjB2CAs3MjRc7/bulRXak9RiLFobSE=;
  b=Ohh6BbE3iaUrMzPYAFCdN2R6o/9zfPmhwuJKu2RUz712wxngd23FmXQo
   9Ykyk0E2pYnIuFN2Bm/N8dqb6QC4ExLJ619Liae30bWD646U1GWVGdfZz
   jOyRcpdJrHfR9+gO8PIHRdoCixOlFJ60xnxmMu3cB5q/0fH6sVmU+w2cA
   4=;
X-IronPort-AV: E=Sophos;i="5.64,317,1559520000"; 
   d="scan'208";a="688518889"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 28 Jul 2019 09:34:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id D64F8A21E1;
        Sun, 28 Jul 2019 09:34:41 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 09:34:41 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 09:34:41 +0000
Received: from [10.107.3.19] (10.107.3.19) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Sun, 28 Jul 2019 09:34:36 +0000
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: Re: [UNVERIFIED SENDER] Re: [RFC 1/1] edac: Add a counter parameter
 for edac_device_handle_ue/ce()
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <thor.thayer@linux.intel.com>, <bp@alien8.de>,
        <james.morse@arm.com>, <rric@kernel.org>, <morbidrsa@gmail.com>,
        <ralf@linux-mips.org>, <david.daney@cavium.com>,
        <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <ckadabi@codeaurora.org>, <vnkgutta@codeaurora.org>,
        <jglauber@cavium.com>, <khuong@os.amperecomputing.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
 <20190725153658.084ea1aa@coco.lan>
Message-ID: <355dc172-52f5-3d9c-883a-4ad1fd10d54c@amazon.com>
Date:   Sun, 28 Jul 2019 12:34:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725153658.084ea1aa@coco.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 7/25/2019 9:36 PM, Mauro Carvalho Chehab wrote:
>>   	/* Propagate the count up the 'totals' tree */
>> -	instance->counters.ue_count++;
>> -	edac_dev->counters.ue_count++;
>> +	instance->counters.ue_count += error_count;
>> +	edac_dev->counters.ue_count += error_count;
> Patch itself looks a good idea, but maybe it should rise a WARN()
> if error_count == 0.
Good point, shouldn't we use WARN_ONCE here? if the user call 
edac_device_handle_ue() with error count == 0, it not be change in 
run-time, only if the error count parameter is calculated somehow, and 
it'll be the *caller* issue that didn't check the error count.
What you think?

> 
> That applies for both CE and UE error logic.
Sure.

Thanks,
Hanna
> 
> Thanks,
> Mauro

