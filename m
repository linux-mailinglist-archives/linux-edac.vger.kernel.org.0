Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0B6E6BE8
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDRSRi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjDRSRg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 14:17:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E8B759;
        Tue, 18 Apr 2023 11:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu8j3Xmnc3wwP7FZPTXGlx1NZbkGiRDGpftzWfp3+MCzh6P0mu2RadVlLkIUyAqpGGb6BbcqtICZYVlqmusjmJZuVQczojvdZaGWU1gUezcUF8bzh7RFiraJNPmeTIkp6eqSrAdDqYyByTT2MYqhf2Y9i+I3TEkm6IbEeTsODizsjZ1VJjjiJR7CjM+cfB2Z/9QVCQfAqJa8VfuLpvCpyMtmWAdtIgoQRjBCvzBKAjZ45/PSjHQmya0hpClN+V735Htcbt9CKMv3cZAZ+Rtmyfk2M9JOpIyNQuJBT6DYh49GBsgk+v5tnXY2YYpqd/Ci2FEHSH3AXnfMt1Gh67L/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tCtyMx63RXhLUDcKMwWz7BWBt05bEGF8ybDs6XVvcE=;
 b=goM563fF95iZJdikPDCbq4svPegVRWysKMRtjiCaXnqCuLCi8twlJpJ2GnGaUUHV8NjN9s4wFXwaoZe95JpMRPKp5G91Fl6Pp9iNoPEbmD4/b12aZ9smx3ZBFygtA7Vl1qoT9Gu3aWB4Q4fL0r9wyqOb9JFqVF764M/NPbhVmb/4bLJr3z0NhRBCYoySCJ1967JyA35wFkrixWxo1ttuP6uZ/67OaWxfZLSKahEMQ5o3oKuzZ9cMR/A5WbSB74RgMXSWXW3S1B0r5cb53rn//nvGIxHYyCuE7A1aTo8mpEoiJIV/1GAzvtWaE2jHYxbsEvVjmqfE6ko9PJFG+tXNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tCtyMx63RXhLUDcKMwWz7BWBt05bEGF8ybDs6XVvcE=;
 b=LLkr5rR3Dyf349Li3OJ53KbHyFru95GcLMl0BQtfaCvyBvhOn/PvDdm/LGNf9MVk+Hj7OD56Qp3bFQb1SURFzg9x93nqRzqXcu/AbUgYPDcJ1+fe8zyqIui32jUzK0hh7hDXvN5IaEcUaqx2QRes/xVneOO98RJ4m5eXt66tf0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 18:17:27 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 18:17:27 +0000
Message-ID: <93d0e5e9-eec1-cdab-be5b-cd65f792e5ac@amd.com>
Date:   Tue, 18 Apr 2023 14:17:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2] x86/mce: Always call memory_failure() when there is a
 valid address
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
 <20230418180343.19167-1-tony.luck@intel.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230418180343.19167-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:408:e6::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: a35a5c5f-3207-4853-e46e-08db40392a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tfey1buY4sfc0pEoY9L8aPH5GlQZZEYq4qIuvGCQ4n5nd6ei6vdnrwz1T5VW5Nc7mN2pQvwwni3P4Zq6zIqIO5J+oJHRfrwPA9wizlEz49ly5bGNMzrl9kGheb9qkmQWMgO/h3+BKTLWMUioYLgh4oxYerpZy7ZqtFz34sS40p+2k2tHG3fftQmmbGh+w8jxu0TjdcDV4i3angnxR5/zmcW9Y/dMMQ1I76RgT9V7xvsjgFOdJk/Qh3ZuuI49wVQ/dCTLuzXkNYqrZXL8KsVbfKVjxmilsDcSv5ok3CYBzQ34Y0XFBwKL56nIIBb8KrK2pkb9cJBUOnqTaKotA2GEdqp+t/OL5eKFZDMUMEi4tsCx6wpGoawcLCkeTTrZe92Ezkm0OcaPn6/iD86vxLocdPmSNEEd882xV6NnAeKE4sQgoCHurTPH6lImRh9leXDis1+soNrQOW2eqm5JlIgvY1ePUqqUuy25PrKnoaqMLT4ZRIaKlrGDDFxMPFFu4DuRBNShZ2yZq2Is/yw8BO6h+VEOvzPguIXPHJR05sPoa0RDZlGM6AUSO3IjdypLBd1FDh/GHTPBvHX3XPu0FC394ggx3r3Ln2aBCPQMmpdXgIIOK5468bF/Ue5mrSHKF9QXi2hzinRYPbkPaVndQtU1IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(26005)(186003)(6512007)(53546011)(41300700001)(6506007)(110136005)(86362001)(83380400001)(2616005)(4326008)(31696002)(316002)(66946007)(66476007)(66556008)(2906002)(8676002)(8936002)(6486002)(44832011)(31686004)(38100700002)(36756003)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnU5N1JRM3NKbWlTOExMOGVaY1Jxb0FVUlY2K1ZFcS9ETm9JMUVsMmp3RFMw?=
 =?utf-8?B?UCs1cGZuMk9ET0lhb2RzQlcyU3d3aUJ0UXN5QVR6VjhRRkpBNjh2MTVybUsx?=
 =?utf-8?B?OXhaWEpCUlFMRmljZTI1VGl1ejN4T2VPeW9Xeng0NWZHQzBPYzc1Skp2Z09V?=
 =?utf-8?B?RjdkSFp2ZEU3VUJ6K0RQR3BkLzdXK1krUGtwdFlYazJhSlRMYnVPUGx5ZDd3?=
 =?utf-8?B?OFdLRGdHYmNUcllRRHpMbVVUSFQ5cE1uUFJ1MktERnRKR1lUVmUrVGtmNFFO?=
 =?utf-8?B?RklWaE1RZXQrKzNIV1E4bzFmL2hXNmtGc0ZFMGhNRE1WY1ZJQnhrTTNsWDE3?=
 =?utf-8?B?TUhNVnRkVjJnNlVDWVFpSHphR0N4ZG8raS8vaWFWMFpMQWJwbGQ2TmxCclYz?=
 =?utf-8?B?bGdZM2kyaXM1WDlNcjBGcWgxSGlHSlNkVnIzRDNkSDZpbVNmbHE3MjRiUzRO?=
 =?utf-8?B?VmFVTzFFems2OG1OYThCR3hJQWZFVE1FTWxBaVJLVXNSeFJVYWo0clJmL2J0?=
 =?utf-8?B?SEJUT1pQUmt3bGlXSFdIMmNDN09FTFZmaEVQRTNmZWUxWjVMYjEraUkzRGF5?=
 =?utf-8?B?M0pVUUhKTzRSeFROUVY1c0ZqbXBQZWhWY1VZengrcFRNWDdzNFJLb2ZHV2Mv?=
 =?utf-8?B?WmVlYkZ6QW1IbzVtcy9haEdZRy8vT3Z6UGRWY0JYSWQ4dmptN0pVeWg2OGFm?=
 =?utf-8?B?d1k5UlU5T1dxQTF2Mno2RzVnUjQ2RXhXd3Y5UjRYNWtEOERqa05ZVmNvc1VE?=
 =?utf-8?B?TjdsMEU0OFp0bEowYTFaaGtFZDdQODErY3RTZUFDQ01TOUtSQlg3eFcyNm5z?=
 =?utf-8?B?WTZEVFA4NE9kZGgyNUpxLzBTbjZWckk5LzFlMXBpL2c2SmlZL2NBQzlZbGlv?=
 =?utf-8?B?dUJkcHcxODFyWGw1UVI4SXhrK2RZcXZINDdxbC9WalFXbElSaDd5RDhTU3I2?=
 =?utf-8?B?T0Y3RzFza2c4V1doSnovSG03VVRXWGVSSlFTWThQa0dablYvUExVQnpkY2oy?=
 =?utf-8?B?eXZKM01ZNG1SQW5iTnU1ZjczUUM3NzRIQnZ0VHppR1pkbEhvQUlYQUNIeVQw?=
 =?utf-8?B?NCtERTNNQU90anBPZTNvMWlOTEZ4ZjJiRXo1ODgrMjV2M3BsQitRMHRMN2lu?=
 =?utf-8?B?Q0dJZ2pCZmU5K1lnclo4V2FjNit5STVMdFZaaVlxbkk3T3E2LzFyTkxTYzFT?=
 =?utf-8?B?alhSS0UycUtJczB2VmNzZXh6blBLeUxtS1EwQVZLTzlRUU1wdk92ajZxcUU0?=
 =?utf-8?B?VDEyQVlScXNrTXBjS1F3Rms3WWZBTkNLem1DUllJdk1ScWs3TE45emZzTjZE?=
 =?utf-8?B?N0wzWnh0dC9oOEE4RVZRR0hrNHlMeWx3VE9GSEVLZGN1Y2k3RmlrUEZqWGJm?=
 =?utf-8?B?MEFQMS9NSGlZdkxLYXhNdlczRkZ4clp0ME5jRm5PS1VsdDd6NTlmQXRvN1hQ?=
 =?utf-8?B?MG1zRGdjVlVmZVZQdkxkRUs2K05hL0MzTjVtdFkrWmMvY1B5SkhLVUlVM0h2?=
 =?utf-8?B?dkxiKy9rSkUrdDhkcENIQjBoaU5aSlJJOFVzbzdBWHQ4bGtIVklyb2R0UDFO?=
 =?utf-8?B?RmN5eEcxQ0dJWHJ3THhrTG5KWnV6ODE3dk5WdnpYWXBmVDNtM1hMbXdxc2Ur?=
 =?utf-8?B?V1BDMmgwSFgyZlJyaC9UL1N1czMyNWd3YXIrZ20xRHVrM2QwcG13NDB6ektv?=
 =?utf-8?B?di82SlRCQWh1Rjd2cEdKYVBzdHBzTFh4ZEtFUHNWbWdBbDJaR09id3FudXkr?=
 =?utf-8?B?N0NibDdVYkdqNW5BQTRqQklsQldNZmtzeFo0TWs3c1lPMzd6WEtPYWhhM2pJ?=
 =?utf-8?B?VUlPM0ZYRi92YWFyeFZvb2hDaEFYcVNoZTNQSDA2RXFxMUZNSzZvdDViajN5?=
 =?utf-8?B?YkVJTGltNi9QU2hyVExrN3lLcWNlVWN4MjhDWUJ1Q3ZRc0FOeGl6MDA5YnRY?=
 =?utf-8?B?b3QremltUGJsQUxXS3ZVVjlqTUJ2UW93Vk93MnVqR0wzQzZZWC9sOWt0bFZE?=
 =?utf-8?B?ZVdLaE14dUhKa1dsR2ZZbDl2U3VIK2hOZisxMjZJQmFYOVFKS2NzekVSdFg2?=
 =?utf-8?B?ZHZGbHE1WHhDald5TXpRR0FyTTAxcWsraEl3TzVQUU93M0ZIQUcwWFJPRGtQ?=
 =?utf-8?Q?/c7Ks1fXoZYzCSFwaacpMZmW9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35a5c5f-3207-4853-e46e-08db40392a64
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 18:17:27.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFHq79jPt/5b1a3VrjYj8JBHjYifhjrUh13IUgn/FezbftQmb96FVZyktwivYQ22qqBDHYwbukwmfiIGIWBGRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/18/23 14:03, Tony Luck wrote:
> Linux should always take poisoned pages offline when there is an error
> report with a valid physcal address.
> 
> Note1: that call_me_maybe() will correctly handle the case currently
> covered by the test of "kill_current_task" that is deleted by this
> change because it will set the MF_MUST_KILL flag when p->mce_ripv is
> not set.
> 
> Note2: This also provides defense against the case where the logged
> error doesn't provide a physical address.
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2eec60f50057..f72c97860524 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1533,7 +1533,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		/* If this triggers there is no way to recover. Die hard. */
>  		BUG_ON(!on_thread_stack() || !user_mode(regs));
>  
> -		if (kill_current_task)
> +		if (mce_usable_address(&m))

This should be !mce_usable_address().

>  			queue_task_work(&m, msg, kill_me_now);
>  		else
>  			queue_task_work(&m, msg, kill_me_maybe);

Thanks,
Yazen

P.S. I had the exact change in mind. :)

Copying old patch here. Feel free to reuse any of the commit message if
it helps.


From 1123d883470c49babe7c390c67e604b658acb913 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 8 Jan 2021 04:00:35 +0000
Subject: [PATCH] x86/MCE: Call kill_me_maybe() for errors with usable address

Call kill_me_maybe() for machine check errors with a usable address.
This ensures that any memory associated with the error is properly
marked as poison.

This is needed for errors that occur on memory, but that do not have
MCG_STATUS[RIPV] set. One example is data poison consumption through the
instruction fetch units on AMD Zen-based systems.

The MF_MUST_KILL flag is passed to memory_failure() when
MCG_STATUS[RIPV] is not set. So the associated process will still be
killed.

The scenario described above occurs when hardware can precisely identify
the address of poisoned memory, but execution cannot reliably continue
for the interrupted hardware thread.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89c81e9992d4..bc2523384357 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1555,7 +1555,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		if (kill_current_task)
+		if (!mce_usable_address(&m))
 			queue_task_work(&m, msg, kill_me_now);
 		else
 			queue_task_work(&m, msg, kill_me_maybe);
-- 
2.34.1

