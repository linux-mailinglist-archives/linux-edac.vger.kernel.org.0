Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC9D2C86
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfJJO2g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 10:28:36 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:57655 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJO2g (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 10:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570717714; x=1602253714;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MbNhUYiQT/iwMjwdlqMi5LP2NhQ+5+8OhcRLlxcsKBY=;
  b=SmGbXwl4vtV5RCIgRvc9Z3NPriaB4WIPaH43pM0Ddhw9TkX7JWQ+Eb5R
   vUU2lJuozjMW+JD7F/Huq0PWJqE0LoqF7qapu9N4BWZRN3vhxso+C8Fet
   bCg5pBpDPiVGcWLS540UVacrCoLiVkBWcgbqmRCnton3BDKb7GSCWPFsQ
   Q=;
X-IronPort-AV: E=Sophos;i="5.67,280,1566864000"; 
   d="scan'208";a="791395129"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Oct 2019 14:28:31 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 62D8DA29A8;
        Thu, 10 Oct 2019 14:28:30 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 14:28:30 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 14:28:29 +0000
Received: from [10.107.3.25] (10.107.3.25) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 10 Oct 2019 14:28:25 +0000
Subject: Re: [PATCH v6 3/3] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
To:     Rob Herring <robh+dt@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linus Walleij" <linus.walleij@linaro.org>, <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, <benh@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
References: <20191007151730.7705-1-hhhawa@amazon.com>
 <20191007151730.7705-4-hhhawa@amazon.com>
 <CAL_JsqKk1SeUTPdVOC_5ewC+xqdPMZbBxiqZHYO3Zdme06P57w@mail.gmail.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <9b62e2aa-4503-02d7-2448-cc0697464046@amazon.com>
Date:   Thu, 10 Oct 2019 17:28:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKk1SeUTPdVOC_5ewC+xqdPMZbBxiqZHYO3Zdme06P57w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 10/10/2019 2:09 AM, Rob Herring wrote:
> +Sudeep
> 
> On Mon, Oct 7, 2019 at 10:18 AM Hanna Hawa <hhhawa@amazon.com> wrote:
>>
>> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
>> report L2 errors.
> 
> I was curious why you needed a DT cache parsing function...
> 
> [...]
> 
>> +static int al_l2_edac_probe(struct platform_device *pdev)
>> +{
>> +       struct edac_device_ctl_info *edac_dev;
>> +       struct al_l2_edac *al_l2;
>> +       struct device *dev = &pdev->dev;
>> +       int ret, i;
>> +
>> +       edac_dev = edac_device_alloc_ctl_info(sizeof(*al_l2), DRV_NAME, 1, "L",
>> +                                             1, 2, NULL, 0,
>> +                                             edac_device_alloc_index());
>> +       if (!edac_dev)
>> +               return -ENOMEM;
>> +
>> +       al_l2 = edac_dev->pvt_info;
>> +       edac_dev->edac_check = al_l2_edac_check;
>> +       edac_dev->dev = dev;
>> +       edac_dev->mod_name = DRV_NAME;
>> +       edac_dev->dev_name = dev_name(dev);
>> +       edac_dev->ctl_name = "L2_cache";
>> +       platform_set_drvdata(pdev, edac_dev);
>> +
>> +       INIT_LIST_HEAD(&al_l2->l2_caches);
>> +
>> +       for_each_possible_cpu(i) {
>> +               struct device_node *cpu;
>> +               struct device_node *cpu_cache;
>> +               struct al_l2_cache *l2_cache;
>> +               bool found = false;
>> +
>> +               cpu = of_get_cpu_node(i, NULL);
>> +               if (!cpu)
>> +                       continue;
>> +
>> +               cpu_cache = of_find_next_cache_node(cpu);
>> +               list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node) {
>> +                       if (l2_cache->of_node == cpu_cache) {
>> +                               found = true;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               if (found) {
>> +                       cpumask_set_cpu(i, &l2_cache->cluster_cpus);
>> +               } else {
>> +                       l2_cache = devm_kzalloc(dev, sizeof(*l2_cache),
>> +                                               GFP_KERNEL);
>> +                       l2_cache->of_node = cpu_cache;
>> +                       list_add(&l2_cache->list_node, &al_l2->l2_caches);
>> +                       cpumask_set_cpu(i, &l2_cache->cluster_cpus);
>> +               }
>> +
>> +               of_node_put(cpu);
>> +       }
> 
> We already have what's probably similar code to parse DT and populate
> cacheinfo data. Does that not work for you? If not, why not and can we
> extend it?

As I saw in cacheinfo it will return the cacheinfo for the online CPUs 
only, correct me if I'm wrong..

Here I'm parsing all the L2 info for all CPUs depends on DT to get 
"cluster_cpus", and using smp_call_function_any() will call the online 
cpu to read the L2MERRSR status register.

> 
> Then your driver might work if the data comes from ACPI instead (or
> maybe that's all different, I don't know).

No plan to get it work on ACPI, at least in the near future.

> 
> Rob
> 
