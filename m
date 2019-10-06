Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526A4CCFDD
	for <lists+linux-edac@lfdr.de>; Sun,  6 Oct 2019 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJFJSz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Oct 2019 05:18:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26538 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfJFJSy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Oct 2019 05:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570353534; x=1601889534;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DvFDDRFwzFZpm+9W9t8azYWL1u/Z9uXnIXeKEaiewcg=;
  b=BIF5Ii9LHene3X6hc/jjfpm9SSQCSojXINxUEWgFs70e4y5S8hnTbZL6
   Bc203boKAlxDlFAKf29fBOoocU5G3JQDdH1w7LcogOL87cP8Zmy63tgjX
   zOjRtP4Z5FyShdyyvhAT7cBltdIE4b6P8s/abyeXdaoJgx/vlvoix2lfW
   M=;
X-IronPort-AV: E=Sophos;i="5.67,263,1566864000"; 
   d="scan'208";a="707021097"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Oct 2019 09:11:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id C8E90A22EE;
        Sun,  6 Oct 2019 09:11:05 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 6 Oct 2019 09:11:05 +0000
Received: from [10.125.238.52] (10.43.161.192) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 6 Oct
 2019 09:10:56 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
To:     Rob Herring <robh+dt@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>, <amirkl@amazon.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>
References: <1570102361-11696-1-git-send-email-talel@amazon.com>
 <1570102361-11696-2-git-send-email-talel@amazon.com>
 <CAL_JsqJDJF7h=nSw3dkNF=H3ghJeLR=MUgrEh+qxw0jhDnfxFw@mail.gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <ee5a0727-6cc0-062b-0797-20fecdf1a450@amazon.com>
Date:   Sun, 6 Oct 2019 12:10:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJDJF7h=nSw3dkNF=H3ghJeLR=MUgrEh+qxw0jhDnfxFw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13D04UWB001.ant.amazon.com (10.43.161.46) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

thanks for the review.

On 10/4/2019 6:05 PM, Rob Herring wrote:
> On Thu, Oct 3, 2019 at 6:33 AM Talel Shenhar <talel@amazon.com> wrote:
>
> Fails 'make dt_binding_check' (drop the '-'):
ack, shall be part of v5
>
>> +
>> +examples:
>> +  - |
>> +    al_pos_edac@f0070084 {
> edac@...
ack, shall be part of v5
>
>> +      compatible = "amazon,al-pos-edac";
>> +      reg = <0x0 0xf0070084 0x0 0x00000008>;
>> +      interrupt-parent = <&amazon_system_fabric>;
>> +      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
> Not documented.

looks good?

    interrupts:

     description: Interrupt for the error event.
     maxItems: 1


