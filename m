Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2C6E4F34
	for <lists+linux-edac@lfdr.de>; Mon, 17 Apr 2023 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDQR2v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Apr 2023 13:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQR2u (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Apr 2023 13:28:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC1E57;
        Mon, 17 Apr 2023 10:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc2AQ3gUlnv0MkhU561vJwu6y7b8Jr8W5ixa4pNJN/i0caNHHVoJc+glVw5ae0k95Ghpcsat9QTdbVqn2AbBIev8rO9g9pB8vPYNw0bpd5gmURT0Q86JVupJqgwOwM+j2PNRjogcFqI2K2Qpuo5+RvgIeoz+1HiXlDOuSLov/JG4B9PdUYhbVmnaIA8m+cpStxMHd0jklK6sxJVznn1JaN9lEo2kSXZJBAhaxiltF0JKUdPURNHceevDsBYNxodKL3yHKqMct7R9BDr140hbAnEcJv+AF+5G2uC4dZf1knU5NxpfBdgCiD8QkKKWZsTDuMX0Re6gkUEC38NVp9TCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHllSIQ20kJ3DW4Yerz0ebUv3EbRJiCutyjNbTHsDrE=;
 b=PdmLQOGmBaTL16Qz0L2rloAdcm4jbRTtkwgPooIBMW0LheoXT1zQwlWZhm16vzXTVf+rJ1nYE0AZtZXF3tNzlq/XlI2VIiWNuv3BdeFKniF2U8A7egNlg427FWnckhlJGLGMGUMI/4WPL+WoXn7fmOS3JUZEhi2trw3IK737sukbPFp4v/e5q09O3wn/+dSalM779YV2QMk67LGp+iIjMGb1ahq8FGXHNh+YSbO395gVz02oQHU+lQUhJPKUSqJOCH+aYKngYgWRBybpT+x492AEhSe/xYd5RM5z5Nc/bNj+3UYutfi0IkZbXzWHRFdE7y45tk/1K6odI78lmwMd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHllSIQ20kJ3DW4Yerz0ebUv3EbRJiCutyjNbTHsDrE=;
 b=kU6Vmz6XqMgSeotA/hBylPtwPb2U/3kKXcgrGoox3JVCi9EUBOcCde5QT0DM1vDfPf2fFpMV3SJ/bZVN3XaT9Q6CbpS5hM3+5TzwDx9umzRbPq/XpsR1cU4Jpbyg6Z3SUD2PStuu5tD5bkbkNEhgBkKQ+JKlRKMGjW9sEYF6Paw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 17:28:47 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 17:28:46 +0000
Message-ID: <7b316c31-ded2-d6d5-0315-dd4906ff833b@amd.com>
Date:   Mon, 17 Apr 2023 13:28:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
To:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <SJ1PR11MB6083E6A167F4542AB439F09AFC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB6083E6A167F4542AB439F09AFC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0641.namprd03.prod.outlook.com
 (2603:10b6:408:13b::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM6PR12MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6fe3ee-7049-4ad7-30f2-08db3f693316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBY6SZjGqaznzUpGCfDJcX26ANpEBVy76K/Z5D2P9HIggCuqDRwM/HHe6VqWExMJnV30aE9XpornSfqrWQILO1Kfil+JoU62IUnykdSsyIzzlWovTAfI/8cQzl1cWdZ4ej9vN3tlGhWF3DFT6V9ZoaocdU/BuKRYx/wOPi28Oa7Y0s4Nb0qhCBz8dEUqXUnwfEpVlIB02rNh1MemGi3wNtnMN+GukroRszqsJTs4vpiLBKurjxPtD07WsL65aXD3goB9vDBpql/lX186gNlp2Ypi61XLjO5xEQBas10uPhrbmH/MXb39tG18zThIj0PrCD6llZgWR16Rpb1G/arwq0XZjkQFBA/R2oW51AzD75TVMXYz+bSsIweDXMGpIHh0OmZLceYDXBdwt1I92lPRA1B7bmPEIxcHgyJi8XM01DH9JMdULtzJ0HSXaskNzj5oS4YufPu/FEDIzAHNvJeorlV8T2VvSpAzO9YxI2EeQK0LthHv7yrLt/Tu0HrwsP+wyOfgss87G1q4NhLA1Umo+9Fyo26JhjpdyrcX+28Ds0rhaIxObOdiX6ae0guqytd+eSggnifUzsKmEexVmGq9EHqaH74D0tG69VaAkcF9iXlZne/IsmV4pKJ4tMHIZoz8Dc+Q7uIwgBS1kVxQh8HfBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(36756003)(44832011)(2906002)(4744005)(5660300002)(8936002)(8676002)(41300700001)(86362001)(31696002)(38100700002)(31686004)(478600001)(54906003)(110136005)(2616005)(26005)(6506007)(53546011)(6512007)(186003)(6486002)(4326008)(66556008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE5xWDFSMVV0S2ZvNEhuM3ROMEd5NEdUUmtYUVNRYnpmL0ZvRnNmWllMbkRy?=
 =?utf-8?B?N3NNamFrL3Fxa1EzcVI5WnA2WGRFM2EvaVJoY3Z3eVRCSkVKK1NOVEo1a21s?=
 =?utf-8?B?VUhTRklLTXdkT2RFZmVNUytHR093N1p4V01xcTJTcS9RL2VkSGM2dlljTXpl?=
 =?utf-8?B?dWFZdzloc3JDTVpVOGNyejZEMHBSdUpQUWlsNzZBelh3VW16V3lGZUdYU1JM?=
 =?utf-8?B?Tkw1TGh6cVM3eHNoRTluQ2dzWjYxT3pybXpZaG51ZDEzNWNHajl6blg0OXJj?=
 =?utf-8?B?UE5ZMkY2M01wZEdOdVlGY0pKanVoV3UwTFZ2dFpMTWphOTA4TWwvQVRFc1Er?=
 =?utf-8?B?M2NGcElvSDdaM2VoOEFLYVdDWkNJeFZoVzBEb3lheFh5UkpNWDNYWU9XL1hH?=
 =?utf-8?B?VWNjNHJ1T05ydjkwWnFVZm5SU21zdE5sRnJNZGdCM2VVS1duajJMa3JoVVd0?=
 =?utf-8?B?TGRNcDMrejNNZWJ3U2FyelhLV0E0MjRob1pGV0hzTWNoYSs5OFJKUERpN002?=
 =?utf-8?B?a0w5SWF4SVNyU0diREdTR2JkUmdqTGdFVGVNZGRqTFYxSitxMGZoUjlQUEV0?=
 =?utf-8?B?aitmM1BjTjhrRGNMMDdIQ0JIOVFZK2ZrTjhabTZLdlZzMkk4UXNvRXRlYmJv?=
 =?utf-8?B?YnRVbUFTVnRpempaN3NGVENocnUyZUlTNnNEQVR1VXFzcHNLc0tBb2JldHJ2?=
 =?utf-8?B?S2FWcHFma0pNMnYwYkZidUd6THlmNk4wNTcyY2tFTnl1N1hjeFZlY2ZVR3Jz?=
 =?utf-8?B?cDc1aVdLdWFRajVTNVV6NDZuL2FRdjdBc0ROd0VRRmRzVncxdWhZTzR2RnFC?=
 =?utf-8?B?aU10Vk1rekM4WWJIQ09rdUN5NDhIOFJWejFsaFBTVWgxWjRPVWdTVWdhaTJh?=
 =?utf-8?B?L2lXUzlWY2U4L2ZZSlVpb2RpVmsyZk5iVit3aTRXMmxTT1BXSjRva1ViaWk0?=
 =?utf-8?B?a05PdkFXMjBUeXJOenVpeU43L1o0SFptQi9MUXRESy9LNGdHYnJsYWU5T01j?=
 =?utf-8?B?Z01yVi9icEU0c1FIaGhadXZvZ3hUbTNDSXJpQ1RsaWlvdmNNVElja0gwU0N1?=
 =?utf-8?B?dHBwQ1VqTTY4V3JhR0NYbXJSakFxS3dQbXhnclR3ajBWbUpEOCs2UlNKT2tt?=
 =?utf-8?B?UDZWSGxGRml4MExkTm9jTmIvazdaeTZhMzVmNHdubmZHZG1lWkpmcHc0Y1N6?=
 =?utf-8?B?d0FYWVlsYWsvZ3paVStZMTBFMHNuanVadTJOUElsM1lSajU2QVF2R1R6SUUz?=
 =?utf-8?B?YWZ5MFhwSUFLcEpCVVEzd1lOaWJVK0tmUXo5OHV2KzhaUTFBL2ZyWmF2QnBR?=
 =?utf-8?B?bERFdWFiVHY5Y3UxS2laSHVwTkprSzhid2FZNWxIcExza2t5aTM2eWs2MXI2?=
 =?utf-8?B?Q2d1dEFNNHFESnJxSGhmbVhWYkYvcXRLa0dKbGtBczJvUllHd2piSGthNHVu?=
 =?utf-8?B?VHdkOHdSQktIWGRwNDN3Y01IbVlLQVYwTUdXZEN0Y09Qb3hQSlhNZ1lWdG9x?=
 =?utf-8?B?S0RTcUkxRkZSdWhlMXVJZlU3Tjdmd1U1WEZzSGZNNzhnSzBCQ3hYdWJYWklj?=
 =?utf-8?B?MTlHck5SRE13RHZadmgzSnFCbit2YkthNlRlM1pNVDhnclV1aThyOHFnd21Y?=
 =?utf-8?B?d0V2a0s0dUZkZHFLajN4bVY2eXlzNkhoYzU2Y1J1RENWa0xQVEJuTTVwak9s?=
 =?utf-8?B?MG1wSmpiZzdIdWtuYmVMNEpXK05tOWh0T2k2WEFEQ24xSTBmZzY4RTJRaU1H?=
 =?utf-8?B?VkZuRFkrUDNzRHVTMHZZeXR4VzJnWTNFUWFlMkRubHBPZ1BZT3NxNzVTcEFK?=
 =?utf-8?B?TGU2Nnh0QjdZWDlBSWlBMnZmRVZhY1JTbk4rQm9JUUdSSzBCSXNxbUN4cUt1?=
 =?utf-8?B?MG5BU0grUEJHeGhtRm0rUkdaamZMSE5YZm5jeXVqc2grS3dpdk5JY250TEMr?=
 =?utf-8?B?Q3FFb1VKT05LaThsQlNrT21qbjRYT2FZQ0ZnYkErWllVVTdhai9RSFo1akZF?=
 =?utf-8?B?UEduMGRxZWVPM3BCWGlEWG50ZlNzd0xjMTQ2RTl3ejl0UFdmYkIzR2F3NWJi?=
 =?utf-8?B?QU1ScFpTSzB3Z081c2ZLRHQzL3hFVkJZVGR0MStIdGpOcDJkVWtZeVdidklZ?=
 =?utf-8?Q?GhopXaJfzS/9ADmj8IsPDS7Qg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6fe3ee-7049-4ad7-30f2-08db3f693316
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 17:28:46.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaj8xyIAcB4ZMltodpFVRJhjcJh5Z063fXiNOMdN7Numpap6Ib4jajz1znHb94l2jbC+t6+xYnsyHWP7MuJoMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/17/23 13:17, Luck, Tony wrote:
>> int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> 
> I'm a bit puzzled why this function has "smca" in the name. I think it is called
> unconditionally on Intel as well as AMD systems ... and looks like it will do useful
> things if Intel someday has a hybrid server that reports APEI errors (maybe it is
> already useful on hybrid clients?).
> 
> Otherwise this look looks fine.
> 
> Acked-by: Tony Luck <tony.luck@intel.com>
> 

Thanks Tony.

The function expects the data to match the "MCAX" register layout used on
Scalable MCA systems. CTL, STATUS, ADDR, and MISC will be at the same offsets
for legacy MCA and MCAX. But the rest will be different.

This could be extended though, if other systems will use it.

Thanks,
Yazen

