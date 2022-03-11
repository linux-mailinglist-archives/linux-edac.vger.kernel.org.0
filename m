Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B534D62D7
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349048AbiCKOId (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 09:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiCKOIc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 09:08:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDA10C2;
        Fri, 11 Mar 2022 06:07:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5axo4VoTJjE5lJZwvb2jEaUhogZoQeTlnIeQ34c3bCE74hz5gd09Z1ThDk/aVI9EHqzW5Hhnktqv68OGHUkYKg6+DH/DZGuj3HScFmmo++M3Na19kQKutKhQCTUTwEwtqRgyDwmjcuv5vblkAkT5fEr1ct6CWyBn1HAN+he0t16HC0yxkgX7fmVTSRY9cBNt7FXUcSAoBmDYXj5Ae74h6vvbP0u6IeTwhmIqrj32YwWrvBSaUAw3OfBzpnS36ikOV72cDkN2OwLfa8VCItwWtylrAH8s8NK4LIyIYsAGiO+qImp3z2GT4UQ+rnWNSuvLbVwH/3DpvZBkMRFKRzZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S678nBqKqfOTZhEN9q/6uQdkNJAFq4n32RmdzUyeg1w=;
 b=adAT501i/9XHFCNYzJBR29kVwlv4hRZjiHqfQtpq/dIUES6IdrfHH8c4RFlX8EYEZrCzUKqQZsKOf/F2dR+YWG2+maPWaCxNTUa8jc1kibxM0OBD205kJG7HGcDlz5duf/63I88JEWuYK9egc7QyGfgTuQDMmKmUAtEyOoVBwLbUqJ7aqwUZV56y5Lf5k9q954X0hXNu0UJlt6dWuJngk6EUDXARnWBeR268ihHPpeWuABhasUIvldSV28IEAsDTG+5mVRfrYzfQkl4gPiJcYqiOLpKHnLP6/Pgxguso8zeL+oLC6DQBkHHsX5CKdkrEPjJyN24837h00tF6XAdQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S678nBqKqfOTZhEN9q/6uQdkNJAFq4n32RmdzUyeg1w=;
 b=t6SgrrvlHNQn+3gUK+/2ad6S/vXkuYKx5dAD6gjSswGF68KKkU6SRSrmeg7tNhhqf6PFGeEXI+QtclSUdhs/WnEwZEiSALuAUYweTaFKt5XiPhpXY1WYVQgX5uFVrq1Nhlj7+1qnf9H8W/GKtZD8Dw1NcH45/buYUGw5A5Wl5QY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN6PR12MB1300.namprd12.prod.outlook.com (2603:10b6:404:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 14:07:25 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8940:cfde:90ac:b008]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8940:cfde:90ac:b008%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 14:07:25 +0000
Message-ID: <18a5a49a-e68f-621e-f8ae-16e794a74905@amd.com>
Date:   Fri, 11 Mar 2022 08:07:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] x86/mce: Cover grading of AMD machine error checks
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220309174107.6113-1-carlos.bilbao@amd.com>
 <Yijz7dA1U0AMcYPZ@zn.tnic> <4a345de2-6a2c-fe26-c55c-34ce6ea431d4@amd.com>
 <Yip4EV69+lElCuPM@zn.tnic>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Yip4EV69+lElCuPM@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec6d534-10cb-415f-15ae-08da036877fe
X-MS-TrafficTypeDiagnostic: BN6PR12MB1300:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1300EB62647D68E9E4EB6E47F80C9@BN6PR12MB1300.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vup2sihE9RFVtoCeWzXPcJzkTG2VIzIoY3U/9Q9M6KMc62Bl6r5WANH9YCJEU0QIj0JdMSAjL+Uc/1vCLZz/QwSEUvckdE/2PXyOjN1YEUCTI7eEVKjiIehojm5ncezQPoonE+KfxLk0EOkfxVRjmdlF6+EDFQrjSmiF40Wxo/qLqBKOaUtvOS5nS6a6KbFjpiuDprA6YHSWVLOefm/psMLhoMp5RcKKjToNmGaGKv9kXa2dl4zP1Sz/OGCsemRb+RuOVfNq2gom8e0AAgZd2gs7cGcT6meKalcJXIUHXarTLB2+IL9jYDWbzhxWUq23ugGtrSETeugPX6x/3PtGFTL9o9fJH29XMVWukzWFRDiNWJEkEH8kbXTk2nXD1QbpNj9mZpY4Mu8BF6hprBbY00HBwy+MZqT6sksrqHwTg3XQbobtHMHwo/+1PdtSC3osEhOQUfCAxmCuL3ef+4r00PVoIGu5cD6pK46sqz+hAX95emX81r7SOdpVMqhZnta985/f6kZelebl0NBRhfWTUVlo6nmYounJeUfGf5G1gfdpE7YvWW3tAXWWtInQhHnUo634X66HQlqFPF2+0nwb2k5cG8gW2k+KLaECNpW31ITdWZd50b05WYkNASCJewBXzA5apxqQvNKhZU+0XWYBVsNalEA1yQgfUYYaM6NMqWvjYMlL1WfhvwlcG66RucTkpVKOfSizhDvWHgh7ox8X1NDQ6NXQ/xY5g6dKwSLe31g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(31686004)(8936002)(6916009)(38100700002)(83380400001)(186003)(5660300002)(2906002)(26005)(66556008)(66946007)(44832011)(66476007)(8676002)(4326008)(2616005)(86362001)(508600001)(6486002)(53546011)(6506007)(6512007)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHBPY3FQN2s0RndQSnRpZzIxQjZsdFVMbWZUVzFxT0FTMjBnZ3ZDU2ZsMFor?=
 =?utf-8?B?Z25RMHVzSXUvSUw3WlJSNURCZmxUUHRyMjYzYjZ6MDhsVWlEQ3dIYTNUV1cv?=
 =?utf-8?B?ZytyL1hQLzFlOFdGVVBnMzBCZGhBaXlPREQxYUVzR1BzVkVKUlRCOUFmd3pD?=
 =?utf-8?B?WjZjSmFzZzFMZndEbUFDNSsxYW1CRC9mSVhkZURCd2lNSlBNMkFTZGJ0LzNy?=
 =?utf-8?B?WkFEM05MdE9VMWxkcU4rVFJjb3VpN045NlBONVZmR1IwRytYemRFWlFzbkpT?=
 =?utf-8?B?OE5USjVtMkJUeFgvdGZIL283bFV3cGJGVVEzOHVrb0NYNGVLVW5wcjlHckhE?=
 =?utf-8?B?TzRwMEh5RFY5V3A0SS9udldpWlU2dllCaVVkVUF0S0pLbEpTNkhYbGN0b3Rr?=
 =?utf-8?B?S21nd1gyMzN6c0VjYnNadHR0cjRhVytFKzJtd2hFSWFzZGNTQkc2L2hMUHBx?=
 =?utf-8?B?SXBRM25SNFhNbUVORWgzYkNRQVVPQ2FNSytmZngyZysxYk1RWkpCa2Z5Tm5R?=
 =?utf-8?B?d3Q2V1luL3Y5YlVNQmwwOXdMNDVRTXFVY0F1VXNTbmtoMXp4YUJkRkdxUmx6?=
 =?utf-8?B?bnUybVBUWnlvMmlzMGN5bTh4a3pUQU9weUFHTlhBWmhjMU90a1EwYTZ3V1N5?=
 =?utf-8?B?Y1VvU3ZOM1FqQjJNZFNxWEQwbk9kbEJTN2xhYThzbTNqS1hjWVJCb3BNMXcv?=
 =?utf-8?B?U3EwNU0zcEdCWSttSkxsSHoxT1UrTVk1alFUR015Vmg2OStzZ0RKcy9tdzYz?=
 =?utf-8?B?bDNsYnBLOWdvQWRGc1NpSTd6MjNPOUc1NE4wNkFvSUJBZS9YRTlMdjNQbjlz?=
 =?utf-8?B?dmZ0ZEt1TFN2M0JFeUx2MnVQOHcxVThJUG9kVG5tRm9YaWxvRktDeDhtK2Zl?=
 =?utf-8?B?eE9lMTNPbTJVdlpWQmNxTjAwS21QQjA0bEtpcXVxT2IySm9PNEVQYUpJekhy?=
 =?utf-8?B?VTNrcS9nUEdWUDZhRmU3WVh2UlFFVHYxNFpzTWF0S0ppWEZYWWh0Y29zMTh0?=
 =?utf-8?B?OXoyMlhOemFLS3FCbVE5RUhjdkFlM3N2RUhscno1OWR1VHNiNzBMRUhMM3Fy?=
 =?utf-8?B?bEJxM3VJbmtDZFZJeXJEN3ZFT3BtWGViRE8vSVhNR1BQM0NRWSt0WjZEV09Z?=
 =?utf-8?B?SjZla0tseWRRVzNGY3VhclJpSW1LVlExd0lKQ3kyUWV6Y3RkUnR0UGQ5Y2kx?=
 =?utf-8?B?RzRyTWl0ejd4S29jMXNUNzE3RnBtbnNUQVJSanpKNklJdkorMnROcUNucWtn?=
 =?utf-8?B?Z21pL3dqUU5KQ2Vxa3I5aGhqd0wzemV1U3NiaDhZa2k0SHlhR1E1WGl0V2NB?=
 =?utf-8?B?MzFhbzZzQ0NPbWMrQmk0Ui8vOC9HZnRZVTV1M0FJNHlKQXRuNlNGcmRhSnhY?=
 =?utf-8?B?NHhFdWlQQWdpd2JWT3lHbnQ5QlVCOG1TMHJMNjBPUFQzN0djL1MxSFFyWll3?=
 =?utf-8?B?eWZrZXRtaGJWUWVoTmo3alg5V3Z4WHQrbkdjalFKNUFHQ2doNDR1S3hJTGEz?=
 =?utf-8?B?UEdLVHR0Z2huMjRINktNZEhveDkwRjJKL1RlOW93YW15bmI0NmVJQ25MdzZI?=
 =?utf-8?B?NjQ5ZzZZcmg0Sk5pUzhleGZnbEYyQ3BrbHlkZzk4c3BxMFhXd3FwL3RVMlEv?=
 =?utf-8?B?OXNBS0R0MzRyVFp2UmtTUEdwTEFZZlM3TnZQVllzOHNpVEJFSWpkY2gzMjJT?=
 =?utf-8?B?WTJvaXFWV0Y0OWxiaHlKMS9RZnFzRmRUaXVKQklRVUxEU2dyWTZaVXRKWFJi?=
 =?utf-8?B?bnA5VTBjUjZJMExLVC80dCsvaFF1MnRNRzR4TGZzdkxZcEVQTzZMODlBNTJh?=
 =?utf-8?B?Zld5WFVtYXRUYUtZTm4yOWtIUXhUTmZCSzlwaHp3U2lvTE5VcXN3OTQrU3VK?=
 =?utf-8?B?NWFwdlErM0drSnZsNm9tWmYyTFcrUXBERE1nL2R1eTdhSHkvUkN1UlVDcHdV?=
 =?utf-8?B?SHc3b0hIWXN2N2lUclVKYXdieGpiOHNRZnZuUGthbTd3bm9KQ0lKSkRpNlV2?=
 =?utf-8?B?MHRJd2NvTUdtcDZWTEpaRlV2Vy95VVpQT0VIc2xHODl2RjhkeldzOTF6Y0Fm?=
 =?utf-8?B?SWE5ejZTQVVDSnlKRGc0K0RLc2VNSTRIMUxTbkVTQmdUTjhWU0FrS3Ywb3VX?=
 =?utf-8?B?SFByNVdvL0NQcEdxaVRpOXVGcXdLczBmVFRPSHZJdXlGNytlMFVUMllxeTZp?=
 =?utf-8?Q?bITFXXkkoFALIzAhQsQtoIE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec6d534-10cb-415f-15ae-08da036877fe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 14:07:25.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9vRhYQ64e6uMXr7iM65scj8RNp0z2YZluWdOjlKKGuHc+dF55LVCwciq0fz+2Ro2s5g5uxQrq5KBqO2jWOBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/10/2022 4:13 PM, Borislav Petkov wrote:
> On Thu, Mar 10, 2022 at 12:24:08PM -0600, Carlos Bilbao wrote:
>> We will cover grading of MCEs like deferred memory scrub errors, attempts 
>> to access poisonous data, etc. I could list all new covered cases in the 
>> commit message if you think that'd be positive.
> 
> So no actual use case - you want to grade error severity for all types
> of MCEs.
> 
>> Hope that helps clarify,
> 
> Yes, it does a bit.
> 
> It sounds to me like you want to do at least two patches:
> 
> 1. Extend the severity grading function with the new types of errors
> 
> 2. Add string descriptions of the error types mce_severity_amd() looks
> at, so that mce_panic() issues them.
> 
> I.e., you want to decode the fatal MCEs which panic the machine.
> 
> In general, what would help is if you think about what you're trying to
> achieve and write it down first. How to achieve that we can figure out
> later.
> 
> What happens now is you send me a patch and I'm trying to decipher from
> the code why you're doing what you're doing. Which is kinda backwards if
> you think about it...
> 

Glad we are on the same page now. I will prepare a pachset and include more
informative commit messages.

Thanks,
Carlos
