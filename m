Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0424576B
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgHPLiy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Aug 2020 07:38:54 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:37950 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgHPLf6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 16 Aug 2020 07:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597577759; x=1629113759;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=4tTb9I93XH7QwyWX5/PO8LI1xvs2muBk6/ZVUvGSdWw=;
  b=Eqegr4SUyWX8RP165xsaxM6ph2UfmFHW0tjP6qSvTDUN9X6tlamOlSUH
   DlWfoPXlgqe96pd0xEMcnaDEXXKK2rF+lz5AZHncfstQ35U8um32K7cqU
   u4G9X+BAcqz1Nw8u6aWXoFRwHjLTe8iIYX7ZujKF9MmjbyqmSwBfUsOiP
   c=;
X-IronPort-AV: E=Sophos;i="5.76,320,1592870400"; 
   d="scan'208";a="67056199"
Subject: Re: [PATCH v9 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs
 Memory Controller EDAC
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 16 Aug 2020 11:35:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 576D228212D;
        Sun, 16 Aug 2020 11:35:51 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 16 Aug 2020 11:35:50 +0000
Received: from [192.168.3.188] (10.43.160.156) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 16 Aug
 2020 11:35:42 +0000
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <eitan@amazon.com>
References: <20200728095155.18506-1-talel@amazon.com>
 <20200728095155.18506-3-talel@amazon.com> <20200815183358.GE25814@zn.tnic>
 <5d516c64-ecd8-6f36-5f95-6708fe0f3fd5@amazon.com>
 <20200816112244.GG21914@zn.tnic>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <241ac8f0-964b-10d1-2d7b-eb9f435748a6@amazon.com>
Date:   Sun, 16 Aug 2020 14:35:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816112244.GG21914@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.43.160.156]
X-ClientProxiedBy: EX13D01UWA002.ant.amazon.com (10.43.160.74) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 8/16/2020 2:22 PM, Borislav Petkov wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Sun, Aug 16, 2020 at 12:17:31PM +0300, Shenhar, Talel wrote:
>> Let me know what you think.
> Well, devm_al_mc_edac_free() devm_al_mc_edac_del() look like useless
> wrappers to me and can be removed and you can use edac_mc_del_mc() and
> edac_mc_free() directly. But then you need to cast them in an ugly way
> so that it builds:
>
>          ret = devm_add_action(&pdev->dev, (void (*)(void *data))edac_mc_free, mci);
>
> I guess we can leave them as is and then lift them into the EDAC core if
> someone else wants to do the same devm_* thing.
>
> al_mc_edac_get_scrub_mode() doesn't need a prefix because it is used
> only once and the compiler is simply inlining it so you can forget the
> stack trace visibility:
>
> $ readelf -s drivers/edac/al_mc_edac.ko | grep scrub
> $
>
> The others are fine, I guess, since they're function pointers and cannot be
> inlined as such so you want them prefixed:
>
> $ readelf -s drivers/edac/al_mc_edac.ko | grep al_mc_edac
>      23: 00000000     0 FILE    LOCAL  DEFAULT  ABS al_mc_edac.c
>      25: 00000000     4 FUNC    LOCAL  DEFAULT    1 devm_al_mc_edac_free
>      27: 00000004     4 FUNC    LOCAL  DEFAULT    1 devm_al_mc_edac_del
>      31: 00000124    24 FUNC    LOCAL  DEFAULT    1 al_mc_edac_irq_handler_ce
>      35: 00000260    24 FUNC    LOCAL  DEFAULT    1 al_mc_edac_irq_handler_ue
>      36: 00000278    56 FUNC    LOCAL  DEFAULT    1 al_mc_edac_check
>      37: 000002b0   680 FUNC    LOCAL  DEFAULT    1 al_mc_edac_probe
>      47: 00000000    20 FUNC    LOCAL  DEFAULT    3 al_mc_edac_driver_init
>      51: 00000000    12 FUNC    LOCAL  DEFAULT    5 al_mc_edac_driver_exit
>      53: 00000000   392 OBJECT  LOCAL  DEFAULT   16 al_mc_edac_of_match
>      59: 00000000   104 OBJECT  LOCAL  DEFAULT   20 al_mc_edac_driver
>      61: 00000000     0 FILE    LOCAL  DEFAULT  ABS al_mc_edac.mod.c
>      88: 00000000   392 OBJECT  GLOBAL DEFAULT   16 __mod_of__al_mc_edac_of_m
>
> Thx.
Thanks. shall be part of v10.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
