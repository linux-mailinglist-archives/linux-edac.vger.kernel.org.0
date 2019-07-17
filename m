Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F66BE81
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2019 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGQOp5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jul 2019 10:45:57 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59277 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGQOp4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Jul 2019 10:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563374756; x=1594910756;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1z0z9elD25irdrNcrFhS4p6GbresMpDTWPm/16CxXK8=;
  b=npZoZ8j12E5e49oV4E1vrfc0QxqK81Y9FAdYo7E1RrkIsrQImT01OejA
   xYSBcHX1ruJsABA29KBgdP6oVUUVu5SDsYJ8FzzbUM/3OD8OnEtcTq0Ck
   IgTdRsmvI7u7SuKNCUKxvrueFw0EgS7lynaaWX94SDycBLWOwY2a7aGWV
   k=;
X-IronPort-AV: E=Sophos;i="5.64,274,1559520000"; 
   d="scan'208";a="816747936"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Jul 2019 14:45:52 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id C46ECA2363;
        Wed, 17 Jul 2019 14:45:46 +0000 (UTC)
Received: from EX13D21UWA003.ant.amazon.com (10.43.160.184) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 17 Jul 2019 14:45:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D21UWA003.ant.amazon.com (10.43.160.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 17 Jul 2019 14:45:45 +0000
Received: from [10.107.3.21] (10.107.3.21) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Wed, 17 Jul 2019 14:45:40 +0000
Subject: Re: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
To:     Jan Glauber <jglauber@marvell.com>
CC:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "ckadabi@codeaurora.org" <ckadabi@codeaurora.org>,
        "vnkgutta@codeaurora.org" <vnkgutta@codeaurora.org>,
        "jglauber@cavium.com" <jglauber@cavium.com>,
        "khuong@os.amperecomputing.com" <khuong@os.amperecomputing.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
 <20190717120553.GA10626@hc>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <09f8d807-f4ba-de51-177b-c37ca3a9e377@amazon.com>
Date:   Wed, 17 Jul 2019 17:45:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717120553.GA10626@hc>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Jan,

On 7/17/2019 3:06 PM, Jan Glauber wrote:
> Hi Hanna,
> 
> I'm probably missing something but this patch looks like while it adds
> the error_count parameter the passed values all seem to be 1. So is the
> new parameter used otherwise, maybe in another patch?

Yes in another patch. In Amazon L1/L2 edac driver [1], I'm using loop to 
report on multiple L1 or L2 errors. After this patch I'll remove the 
loop and pass the errors count.

[1]: https://lkml.org/lkml/2019/7/15/349

Thanks,
Hanna
> 
> thanks,
> Jan

