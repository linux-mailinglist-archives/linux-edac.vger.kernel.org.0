Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8C65B1DF
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 13:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjABMRi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 07:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABMRi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 07:17:38 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C39DFE;
        Mon,  2 Jan 2023 04:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672661858; x=1704197858;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=g7PwYlA7h+ObpASfr72fHpdIOcqLRnjFhNhLUHOoiJE=;
  b=uiKMySjdMcwkGjKqpL+xVTz5+JjbBxxM54+5sOD2yJ6nDHaCF3WZzFUA
   tmSVz9qJCC8/vtCOHiX06KmRFhDamTAIWSzynkhyH0hefkuP8iXlLQ6bf
   sr24sABwqU05rReOMRBABgP/dwZb6ok9HPZj/9yKPGq4x6FnwQHDOpDS4
   E=;
X-IronPort-AV: E=Sophos;i="5.96,294,1665446400"; 
   d="scan'208";a="284304429"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:17:35 +0000
Received: from EX13D40EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 07892821B0;
        Mon,  2 Jan 2023 12:17:32 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D40EUA003.ant.amazon.com (10.43.165.253) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 2 Jan 2023 12:17:31 +0000
Received: from [192.168.7.187] (10.43.162.56) by EX19D001EUA003.ant.amazon.com
 (10.252.50.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7; Mon, 2 Jan 2023
 12:17:28 +0000
Message-ID: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
Date:   Mon, 2 Jan 2023 14:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     <krzysztof.kozlowski@linaro.org>, <bp@alien8.de>
CC:     <talel@amazon.com>, <talelshenhar@gmail.com>,
        <shellykz@amazon.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   "Shenhar, Talel" <talel@amazon.com>
Subject: RFC on drivers/memory vs drivers/edac memory mapping for DDR
 Controller
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D25UWC001.ant.amazon.com (10.43.162.44) To
 EX19D001EUA003.ant.amazon.com (10.252.50.232)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Want to consult on a topic that involve both drivers/memory and 
drivers/edac.

* We want to introduce driver that reads DDR controller RAS register and 
notify for ECC errors by using EDAC MC API found in drivers/edac.
* We also want to have a capability to dynamically change DDR refresh 
rate based on thermal values (best to be done in drivers/memory ?).

The pain point here is that both capabilities are controlled from the 
DDR controller.
This create issue while using 
devm_platform_ioremap_resource*->devm_request_mem_region which prevent 
two mapping of same area.

It seems to be expected problem as we have 2 "framework" (edac and 
memory) split while both aim for same HW unit.
What is the recommended way to face such conflicts?

We had several concept in mind but would love to get your point of view 
first.

Things we had in mind:
1) map more specific region to avoid conflict (we don't need the same 
registers on both entity so if we do very specific multiple mapping this 
shall be resolved)
2) use other kernel API for mapping that doesn't do request_mem_region 
(or use the reserve only for one of them)
3) have single driver (edac mc) handle also the refresh rate
4) export edac_mc.h and have the drivers/memory have all the needed code 
to do both edac and refresh rate under drivers/memory

Your recommendation shall be appreciated!

Thanks,
Talel.

