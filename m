Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E71CEF6E
	for <lists+linux-edac@lfdr.de>; Tue, 12 May 2020 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgELIrO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 May 2020 04:47:14 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:63377 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgELIrO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 May 2020 04:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589273234; x=1620809234;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=gNMlbsEeHe7zpUB4XMF6c/jzGNUrHAgukt4yVAIjau4=;
  b=n5XxZdPC9U4rWEYFA8fzX4EdgE1uxtmfTn/iHA+2icLBRQxFGF3hxUqr
   kbalUpX5w2jAgwn8BdFTlZ+350BULsCCSqU1nR7uM8eTu/7TUVMHQRyrU
   oeKtdXI/Buc71j+xnVRGYoJp2Acz7r5M+XGWJSDU1TTv/V0h/APbvPu24
   0=;
IronPort-SDR: eCFAF1WrS2G9sO+TuEsHWsAWf6dEjxKIyOweci2HXGxmub5FvBjXMpp6Vl6liZvxo2ba8GEBfH
 7nvsOsFZkLlw==
X-IronPort-AV: E=Sophos;i="5.73,383,1583193600"; 
   d="scan'208";a="42765443"
Subject: Re: [RFC] Support different block names with same EDAC device
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 May 2020 08:47:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 8B1DAC05D1;
        Tue, 12 May 2020 08:47:11 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 08:47:10 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 08:47:10 +0000
Received: from [10.85.94.40] (10.85.94.40) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 08:47:08 +0000
To:     Borislav Petkov <bp@alien8.de>
CC:     "james.morse@arm.com" <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Krupnik, Ronen" <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, "Hanoch, Uri" <hanochu@amazon.com>
References: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
 <20200511135507.GC25861@zn.tnic>
 <2fc308f9-47d6-7c75-775b-3f6579dfe571@amazon.com>
 <20200511142619.GD25861@zn.tnic>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <50666803-ed9d-670a-e9a0-994547e4cdf8@amazon.com>
Date:   Tue, 12 May 2020 11:47:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511142619.GD25861@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/11/2020 5:26 PM, Borislav Petkov wrote:
> On Mon, May 11, 2020 at 05:21:14PM +0300, Hawa, Hanna wrote:
>> I'm trying to create different block names e.g. hw_block_a, hw_block_b.
> 
> Please give an actual example of the names you're trying to add and how
> the hierarchy you think should look like.

For example PCIe controller interface, that can report on different 
errors, e.g. axi read parity error, axi write parity error, completion 
timeout, write overflow error, and parity error.

Then I think the hierarchy should look:

pcie/pcie0/..
           /axi_write_parity_error/ce_count
                                  /ue_count
           /axi_read_parity_error/ce_count
                                 /ue_count
           /completion_timeout/ce_count
                              /ue_count
           /write_overflow_error/ce_count
                                /ue_count
           /parity_error/ce_count
                        /ue_count

same for pcie1/pcie2

Thanks,
Hanna

> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
