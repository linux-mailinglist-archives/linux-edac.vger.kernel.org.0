Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F927DDEC
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfHAObQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 10:31:16 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55541 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbfHAObP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 10:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564669873; x=1596205873;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CYr97n4jQ+i8XoMJ1ptuHgHbqpfgmK1fn3mN/NxQ128=;
  b=uvyTgNPUjMJ2SDB/3yzQcDNPpyeda2EGVu+gp2VrE8b0X+p60xC5w7YG
   mS2kUCoSOxe9gDQNG5hZXlqOp4i3MQ6cuzR8OiFoCCrLg6Ptqm0AeKXDa
   tIfHsNgIZ132ZQm3aCk0FP5iZEd3IR2IdGUown74YlVTSVnqYp/xZCuDl
   g=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="689971421"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Aug 2019 14:31:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 1C739A2077;
        Thu,  1 Aug 2019 14:31:08 +0000 (UTC)
Received: from EX13D21UWA002.ant.amazon.com (10.43.160.246) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 14:31:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D21UWA002.ant.amazon.com (10.43.160.246) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 14:31:07 +0000
Received: from [10.107.3.19] (10.107.3.19) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 1 Aug 2019 14:31:01 +0000
Subject: Re: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
To:     Robert Richter <rric@kernel.org>
CC:     <thor.thayer@linux.intel.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <morbidrsa@gmail.com>,
        <ralf@linux-mips.org>, <david.daney@cavium.com>,
        <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <ckadabi@codeaurora.org>, <vnkgutta@codeaurora.org>,
        <jglauber@cavium.com>, <khuong@os.amperecomputing.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
 <20190801113548.7leooh57gihixen5@rric.localdomain>
 <7d6aac9e-20e5-3901-a423-d76ac917b251@amazon.com>
 <20190801141701.bmcken464mrqwhdg@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <045bb0dd-6a88-36ba-203f-d0dcb9ae5b62@amazon.com>
Date:   Thu, 1 Aug 2019 17:30:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801141701.bmcken464mrqwhdg@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 8/1/2019 5:17 PM, Robert Richter wrote:
>> Don't you think it'll be confused to have different APIs between EDAC_MC and
>> EDAC_DEVICE?
>> (in MC the count passed as part of edac_mc_handle_error())
> I don't think edac_mc_handle_error() with 11 function arguments is a
> good reference for somethin we want to adopt. For the majority of
> drivers you just introduce another useless argument with the following
> pattern:
> 
> 	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev_name);
> 
> IMO, the api should be improved when touching it.

Got it, I'll update the patch as you suggested.

Thanks,
Hanna

> 
> -Robert
