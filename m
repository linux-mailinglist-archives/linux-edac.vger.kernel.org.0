Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A411CFE42
	for <lists+linux-edac@lfdr.de>; Tue, 12 May 2020 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgELT11 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 May 2020 15:27:27 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:27472 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELT11 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 May 2020 15:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589311646; x=1620847646;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=yvbbIRohS3CmJoXM6RMo7ZRqzp4hyOJJ4sBvTax56mU=;
  b=Sa7kgfCboiaL+6/60SvSgxNjFCrF7bKE4d8MDz4i7sn4y6jb6+3Twewj
   cjf/6n0RF1ib36PQlK0xVCABD/jCLHNivUklllNKlghaRyU6rgKJ5DzKI
   mmL4MnSvT2kn57Ad9lZrDZ3ST5p57RBngigVG4Bc7i207bjcZMN5/ei1C
   E=;
IronPort-SDR: n+poyrgetQmkpGAd2IdNn9v8yW2yJj9aTfOkkFO1vtU7sRK/iEZ6qVQxzy5Bx7QexVj9qcxaWp
 NXPktPNukEVg==
X-IronPort-AV: E=Sophos;i="5.73,384,1583193600"; 
   d="scan'208";a="29968574"
Subject: Re: [RFC] Support different block names with same EDAC device
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 May 2020 19:27:12 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 60ECAA2060;
        Tue, 12 May 2020 19:27:11 +0000 (UTC)
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 19:27:10 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 19:27:10 +0000
Received: from [10.85.94.40] (10.85.94.40) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 19:27:08 +0000
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
 <50666803-ed9d-670a-e9a0-994547e4cdf8@amazon.com>
 <20200512103500.GA6859@zn.tnic>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <d4886b17-3d69-2cd0-2999-6eb10e3d5926@amazon.com>
Date:   Tue, 12 May 2020 22:27:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512103500.GA6859@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/12/2020 1:35 PM, Borislav Petkov wrote:
> The "...pci" layout on my box looks like this:
> 
> $ tree/sys/devices/system/edac/pci/
> /sys/devices/system/edac/pci/
> ├── check_pci_errors
> ├── edac_pci_log_npe
> ├── edac_pci_log_pe
> ├── edac_pci_panic_on_pe
> ├── pci0
> │   ├── device -> ../../../../pci0000:00/0000:00:18.0
> │   ├── npe_count
> │   └── pe_count
> ├── pci_nonparity_count
> └── pci_parity_count
> 
> so what's wrong with having "pcie0, pcie1, pcie2, ..." for those
> different functional units?

The pci layout on EDAC supports counters for parity/non parity errors. 
We are searching for something more general. To add more error for PCIe 
layout, to have counters, and to control panic flag per error.

> 
> I guess you could add a "name" node so that you have:
> 
> pcie
> |-> pcie0
>      |-> name:   axi_write_parity_error
>      |-> ce_count
>      |-> ue_count
> 
> and so on so that tools can know what those FUs are.

Didn't get your suggestion, where can I add name?

Thanks,
Hanna
