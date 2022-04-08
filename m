Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAD4F8FCB
	for <lists+linux-edac@lfdr.de>; Fri,  8 Apr 2022 09:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiDHHu6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Apr 2022 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHHu5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Apr 2022 03:50:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897311DF64C;
        Fri,  8 Apr 2022 00:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An9LknCaIBV/4mUYKipjokP6kNFc3aLMAWnb5gIG7sqUImV95n72O5T5mnCxyHO4PR9pZZc0+4+qvODc7ErEseIFUqd97SCRY/8z+pljRwU85OnJN4ei411/misV6ArsIwaIQXPexDdUa8VCLufjRGLQh8mtjugPAcLP/+VJ2ODqzklqp1cudlZGhJ17lxD8JIOX1LC5g1kH9JPwZT8bnwwxs5nkBSvbYLIHU0RSaJDurEzTmyTZd9IA7RiFoR4flTs7AirS5dsfRR23d6U6vUhpthMT5g77Y/hp9iD+8/jRRgZF2gmZLQ8oWP3Kj99ENwCI99Rwiex7Wf9q//omIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9splyA4jhzASwvavqRwEHc+51Ew2h0hDuP4b+Yp1UaM=;
 b=h0nyrs8ImSNCS64ZwQ4+a3D+F0XNl2nN6y4eNrOvUkt8qMsUCF6voc0Mr7P+y/fyOTSIZn4wX/OdpMO1ggrAyKeV0e+LFgBgeYMbNF4NkN8mR+ErI736bjzwGxnks3h2DGjsKrOHzdN9vGRpA/rgErkTLtC51peDyxUw8dXwJnbxpvNAiBqb++gzkBaxGNt5x1jTjHgn/oc87yP/VnyxOhGa9e0caj016eJ+4Zr1XhefhbedzjKvU4wvFqQu70qv0aXF5/FjE7QMhyoE31lAascULyowHIy2pJDUTr5uzmeh30iOlA673E6MafxGRYoOIyEIRn2Tub7xEfW6dLt4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9splyA4jhzASwvavqRwEHc+51Ew2h0hDuP4b+Yp1UaM=;
 b=shb5JLgmds1ABA15/dRrWwG+GVw629Gc3CEjuh7m+j20qOuaTSyIzCNV2U37Ys8o4EvuiCR5Feu8A3RjWSqF2x9U0uMft+Ve2MRFW2s9c39xRJ6NZG22vXtuixLYQiqoeTALxdYBDLFy6s0cRiNSbSvoruGA7uZgOlSgf2TaDaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 07:48:50 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 07:48:50 +0000
Subject: Re: [RFC PATCH 5/5] x86/mce: Handle AMD threshold interrupt storms
To:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220406063542.183946-6-Smita.KoralahalliChannabasappa@amd.com>
 <b140590dadea411ca3641b0537bfcd9f@intel.com>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <30c01863-85ef-4cd4-9e73-340e2d98b9bf@amd.com>
Date:   Fri, 8 Apr 2022 02:48:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <b140590dadea411ca3641b0537bfcd9f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9909f0-399d-4d01-f2f1-08da1934382e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5187:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5187C1D9EFF5CCE9DF0A3E2F90E99@CH0PR12MB5187.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jYw8Tf6q09Twg7gSp3Sonf5fb6/6H+Mna693r01YMTNLpKDeJ5xeQkPMgeZcjmOxEDxDccdg34Hvs7GtiQZhjYpxWM9b7SGwpdwrBgUJjzmUPT7NkE/0mRWMy2qweBTBpPk6EFKEcRtxLagxFqG3DzJ4QqL5zJKRhHZK9c/vSaWL9HeVqxh/aNjwtHUF6wbbxSMgkXhEEVC+SJcqkAYU0BjMlmwHcXtIij0hCTJ8Ie8d/JcNNqDMskd5Sn5ADYDXANchy2T+qZIlDF8xAJbGthwLqVqJvm3e5eEaeXowkGnbMYGWmJeFdOU1v0vW3ur3KdPaMyAxoRRjjVJEYFK9wHxXLMFHkS9n5hgVp7WgPFjVzCjdDsk5I6PQkA69OaX17onoetwmDepi/vu1tdpHhtBL3HWcipuIaJiuyUk8vcT5utvcx7KI7pwCzEfuWcHi1sdG0G2yr/4xJiuMYuktDlInSsW7BJ5titmOjnamd92A8Z6Zwz4Za8q9cXFSquGosTI14999Gt2V/0qlmOfn26nEC7vRSQKdeIsSdxDdMp5bnKTPpB/Qd+56wd62DjiPaQb2/sPh+/r6UiBO+EsTyn2lz/jlDnloK4ge4V/hcdMV7tfq5DOgQG60R1FO9wmttl0qItHHlG7R6NeK7V7ik/okYmA4hzxIgyrqn+sJvnnKbWBLdfhXsw2zyBiQQL0FJ6IQxJcI+OUUak+s03arh9RS45FIa34J80Cukjw4d0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(4744005)(38100700002)(2616005)(186003)(110136005)(54906003)(508600001)(6666004)(6486002)(6512007)(53546011)(4326008)(316002)(6506007)(8676002)(83380400001)(66476007)(66946007)(66556008)(2906002)(31686004)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJLNWNIZ2FiOUxVdXdIMTl3Q0FzK2ErL3VsSDlIU0RKRGJPRGNRd00yR0Jr?=
 =?utf-8?B?V25UUHpkamF3eXppQU9QVyt0NVFRWU00MGVMYTJEdHVRbDM1UWp5V3ViTmNo?=
 =?utf-8?B?UWRBTXJVcXFXbjBLMlZUS1FWODhBYnozZmNHeklnd3ZqQ3pTNkZFWE5vRnhH?=
 =?utf-8?B?OWw1RzlUSVRGaWMxeEVER2V6MExYNmt3aHBmcG5CeEYxRGRYWlhyS3hGTFd2?=
 =?utf-8?B?VHg5SVk4Q0E2c1ltOVZnWWhSU3gwK3RtYkRwbGJyQUloWml3ei9OcEg0SFg5?=
 =?utf-8?B?ODM2WmN3NEZEVHcvYlcvVXFma3RDd1NwODl3L0xwb2pGTHNXMEU3cDFJbDBX?=
 =?utf-8?B?MUhMZ2dRcGk0K3FoQmxtWGZqbzdPQU9JQ0tPWkY2M0h5UG9BUHNVN0phU3ZH?=
 =?utf-8?B?U2xtMndGU3JaSFNZYmJpNlJ6NlFIVkU3YTVVWWNEUXNQU1pDTnhJNW16WUd2?=
 =?utf-8?B?MGZWZGJQWUxnUWF2aUo5a2VwUDZWWERpRWhuMkdPdXJZbkQ3Z0hRQko4bWVK?=
 =?utf-8?B?cU40UmZGaFIzRGJMT08xRmM1YmZFbEVWSU1xcDBJRU56YmdtZnZBWEdLWHFG?=
 =?utf-8?B?cHFaVERvc04zUWkya21zeDFVSVlpN1JFV0N1cmRvTkRZT3JPdmRHSzVqRHEy?=
 =?utf-8?B?bndjdVplbWpLczUzMk9uUVFReEZzNmhERjI2NnA2VzNOb2dxR3lDN1orc1Ft?=
 =?utf-8?B?Ty92dmUxWDVQVXdVbHZhVkxsZE5xT0tSRGlJYXA3bytnV0Fxd00xUUtnUkFl?=
 =?utf-8?B?ZmtPMnZISGVRN3JDdSsxVkFxWSs5QkprUDB0bEVHeExxeERwYjNpZkd1bHJ4?=
 =?utf-8?B?YjRDNm9yZG5NUWI4WXRmcko1cjZVZFRxY2p3L0c5V01IaFZjRjBDRFg1ME9r?=
 =?utf-8?B?Tm80bzREYXFQNW9BV29PZmFINHZIQ0h5eFIvZkdhQmEwcXZHMEwza1JpdWpT?=
 =?utf-8?B?SGJGUEdLWFZPMXhMVzBvN2hmeU1xekNhN1BYaHRweVh6c0MzcVU5RjNnMnVR?=
 =?utf-8?B?V3JZYjdsRXpvQlNZS1ZPbG45Y2dlSXh1TEkyMUxScnNpY2hjQ1dOc0hGMG15?=
 =?utf-8?B?R3YzbS9rTTczaVRYc2w3MC9KRDZBbnBRZ2M0MW1GN1ppRXhibVhCSzlYYkNp?=
 =?utf-8?B?OElwYXQ4ZkFjeWRqTUx5UU4zYmE5RVFvd3hBY1QvcDFXNDk0c3J5WFBlK0Zu?=
 =?utf-8?B?WFltMWFLVk1wYnkwWTdsZ0tEVEhyUUlQQnBJeDRvMGNsaVIzYWxKY1ZWcVBn?=
 =?utf-8?B?b0JubkxMVFg5VjJHWStoV2JPcUk3SVJnWkZ5ZERKWVI5VjFPZXJyYkFzbzNO?=
 =?utf-8?B?SnJqNktGcnRWQUJYNkQwNHJyckVPRGtRRnVvU2JOUUhSWlMwYWxUemJWRmkx?=
 =?utf-8?B?NWhkZEhhbElCS0lYRWx1OU9EOUN2cmJaQkFwTUt3bFhEWHR4VlFNUGpvc0tW?=
 =?utf-8?B?UXI1NnJwKzBSVVlCSzVDWEJEM2ZKb0hkd3BJNXJjcHozRm9vdzI3d1BvdHdt?=
 =?utf-8?B?aGFMNEtTTWhIVCs3S1A1UHZkQUtIZXNxdExFQlpFL1c0UWd5S3E1MmZwWUdF?=
 =?utf-8?B?MkxkWkY0TURlWjNqWnFwVFh1VnozUXFVV3NpL2lZay9KSTBINVhvWG5nUnI4?=
 =?utf-8?B?aGVOQ2lNaEkrOVcyckFQU29CVCtwYlF2Ti8yR2hwNXFSaGk1Q2xmS3k0RlFU?=
 =?utf-8?B?Zk9kYjNGOVdnY3VZSjJVcUt0b0NJMVY2NnE0Y2VQaXFaUk8vdENVNThWclNI?=
 =?utf-8?B?WmkrTUxHNDBmRDJ0VE1mcnBlZU9ITldEWHNyU1NQT0t2K0txTFNiVWZHSncw?=
 =?utf-8?B?YkJNZGdTNG5vM3hPa2NleVQxYU1mbEhrNDZSYVZqaFVBaTNFNkh0S0srVlNM?=
 =?utf-8?B?b0ZPWjdZa05udkNHYlBob0gybTdLQnFibDZyUmthUTVMVDlML01HaXR5dFBa?=
 =?utf-8?B?UjNJeWJEQkFvMklsRHltdUdtQmwvRjR2SzdtTHEyb2Z6S25qeUhKVE5UU2Vu?=
 =?utf-8?B?TWNSV0s0T2kxOUx1Y3hocGdiSHU3VHZTekRxTE1TTERvaWlzZS8wMzJDVDYr?=
 =?utf-8?B?dDlVWjVza1IwWFdqek9neEM4MUJkN0cvSklaTE1DcmJaTGd4KzlPSEs3bEFX?=
 =?utf-8?B?VFFJaDcveGtSRXB0Wm13ODFBRzYrek1uZ3VGdWMvVHVyTm9aWDlFRm1iekdQ?=
 =?utf-8?B?d01WdSthaEVjL1NETDZqVG1XbUxxV3k1b0VoMlNVc3Q5cnlKak1VMk43OE1B?=
 =?utf-8?B?cnQybmRxVDNPVDJOdkpsaVRCRk9lWEJGTkRJWHVySmtvbFpZekNOVkxPWEZm?=
 =?utf-8?B?TG5xeE9Hejh2dU0rTGhpUXpqdHg4aENCQk03elJwYVJkekxiS3BPWWhmb0ty?=
 =?utf-8?Q?wexHgshG9c3qjs/PYm0L7Qv0wQhoQfa70bLOXVRwMlbvi?=
X-MS-Exchange-AntiSpam-MessageData-1: N8WKptld5d5nJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9909f0-399d-4d01-f2f1-08da1934382e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 07:48:49.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xtu3ZdC7HLYBEBN7YoYV5Uviu1Z3mKJTtsStNLSUrd1a4f+YcFrq0x8UZzSqkJxXfo8UEoxKGdxCeNRWS02BZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 4/6/22 5:44 PM, Luck, Tony wrote:

> +		/* Return early on an interrupt storm */
> +		if (this_cpu_read(bank_storm[bank]))
> +			return;
>
> Is you reasoning for early return that you already have plenty of
> logged errors from this bank, so OK to skip additional processing
> of this one?

The idea behind this was: Once, the interrupts are turned off by
track_cmci_storm() on a storm, (which is called before this "if
statement") logging and handling of subsequent corrected errors
will be taken care by machine_check_poll(). Hence, no need to
redo this again in the handler....

Let me know what are your thoughts on this?

>
> -Tony


