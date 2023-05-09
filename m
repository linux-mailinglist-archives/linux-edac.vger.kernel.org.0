Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F66FC8E1
	for <lists+linux-edac@lfdr.de>; Tue,  9 May 2023 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjEIO0A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 May 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjEIO0A (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 May 2023 10:26:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82759524B;
        Tue,  9 May 2023 07:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYYj3b4ceR4L8iexqoTvou7s3jS/SB1VTWU/IZgNzynh840HX+PhxNz42utavl81uhUv+6ZLQ+1YhrLXP9IejKIRW6x3nfXYjsn7vLSfHNgEjUSUBYJ3UptSKz0ETsalJaQsDZxIFOID6deYTYH8QxSjAM/UL/hw0mscxgE9xIiTNCIshQ46ZcZV5CEryFLl3khlkJo/ddt8R1AnPzp4nidXhPLsbVemdXdDaAS6Xd/PrTg5ekgmHzj2jv6dwE73aqAQnE6Amv/SUTc++YBK9E2FmTVfIFQsjeoarjl5R72BMZyB8k4V3k6QBBBeCnwiCEpjN9nldMDlBZm6QCi7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pHAsvC7KhrnsIdlEBc4p27RhQ6VY6AqPVJIiv3j66Y=;
 b=MKWWfmZFHPgJxp2NGrNuoGqXAAbnDtjKurfIiMIgVctskG0k7HGjyoeW+RfcfvGoEtpoVd20ohMOaOVz4cRxtiqnudc0jNlTx+4u0exp0gJSjWHOpGKSNagJLrlhOTf6FltaF1jI4uMMX04UlxrvjQff7GZzYACs7NFFnyPv2EidP+mnsNFMLoGQ5tOFm0Gvdsfruk9F6uyLDynYJ0F0Fhu3e6VvR7CTcZ8MHwbVgxFtb0OqxCUeWkG7XDuCiDhFY3490ZMrzC8Qhnkr8UCq14TDCPFw2hNuJ3woTyNtzHpfTwsghYZHOuuTz+oL6t7paD9MjE23QTH8m/pVf1oY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pHAsvC7KhrnsIdlEBc4p27RhQ6VY6AqPVJIiv3j66Y=;
 b=jzDxEl5i4B7YaQ/lK0JhB+uW/irXupqrkesISzivBQqnFJLpFOR2nxL1aez03BTnmBoFF+TjnS865i+TM8W31VZIRf1I5yELdZpoOAe1vZXQ+yUV0KJdZ2aIYqfdo15kiRiHkHKPxbzklmZAotEROCXKTML2NNujQI2p5Pmp0UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 14:25:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:25:12 +0000
Message-ID: <f629820c-50cf-7366-975e-68215b3f2bc5@amd.com>
Date:   Tue, 9 May 2023 10:25:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        baolin.wang@linux.alibaba.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce/amd: init mce severity to handle deferred memory
 failure
To:     Shuai Xue <xueshuai@linux.alibaba.com>, bp@alien8.de,
        tony.luck@intel.com
References: <20230425121829.61755-1-xueshuai@linux.alibaba.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230425121829.61755-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0571.namprd03.prod.outlook.com
 (2603:10b6:408:10d::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d942b76-8b4e-45de-cd20-08db50993312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s30fscSd8cDUOYNzUP2j3xkyfSVEeGBgESmlKrAGvnpMYrGAVIz5CuvP+icQcSg4fw6SeMXcmK16yEjF0B2c6d+ug7OJDiCf80uiSZWJ3eU/JU4ueUfInhsY8mib+2lAdO+qzVrx7F2Ep4TqegM8/f98k21vTuE/uLnKHl0wgWYfWCDcENcIUbY/Drrkj6nlZTQtzk+NJGiSPgzFayKo86danjtZPnAx2Sgy3irNfHfwcocAXOuAZKxDm0jow1UooKRKIqYtT78BoZBKb8J4lw8j3SZavAcspeb3k4QQpy+EGQ/1GxKsAgkB+LEireUieQcXJxOySqK9jGpyMwhJ2DPWA/UBpsu8kHUkC+UrpNnh0OgEq8E5ZekV5PS23nDJS3HRCBzIVfWRVeN/S/WJZ1DtFHpN9PkLgkRl3aUrqFkSs8xpUS8fyU1U8m4OucQhAcxeA3MWp9B/nhYDqWOvdJtnrkrUBsdIe8LqRWzAfMMpdDwCsBy7tR6eoIsUcqasHHlPJjtj6Ldjo81//0DXC0G687V8/+Wli4+aqr61ii7XwiuWknJbc9n5vGy/C5AEFDTxYy393QHgL264M45fAvdayt1B4CV5uLZrWqjHKvCbwxxLoRTuXzKN7pIL6rLE6i6nso6KUPQX2KfZQaG1iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(86362001)(36756003)(31696002)(6666004)(316002)(4326008)(478600001)(66556008)(66946007)(66476007)(6486002)(5660300002)(7416002)(8936002)(8676002)(2906002)(41300700001)(44832011)(186003)(38100700002)(53546011)(26005)(6506007)(6512007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTQ5MEcwdi9PbW9NWVpVTkhDbE53dVFTaWRuYzZWd2ZseU9sdVM3VlVWU1Q2?=
 =?utf-8?B?YUR4OWJDYW9UakZaZUIvUGp2aFFuLzFDY3BLSUk1TkR6cGJqM3dpTGxFa3J6?=
 =?utf-8?B?bWxWcEk4NDFDUVB4VUhWN2l1RjF0RWY5d3dDT2JPTExIY3F4aEgxUGVVTVUw?=
 =?utf-8?B?U1FVdTVPRVY5QXpCK2FVUHRtK3A2YnR1VGVtQ1dhYmlkNTQrZWt2RExrbXE5?=
 =?utf-8?B?eVZDSVNIY0lSZngyNUJLbWlFcnUwUUxaOTlHd3BNTU1VRzNzREw3SXFJMGZ1?=
 =?utf-8?B?WVBQcUk0N2tJbFV6Ym1WVkEvTVQycFpxcStIZXhQSG92TFFpUloyYUt0eTRu?=
 =?utf-8?B?K2ViR0xMb3RaeU9qNy9jMmhPWUJKbnNuMFR3RDdGMWJ3d002K3MzblRwSGQr?=
 =?utf-8?B?RHZUZjJmMHlWSFI2U1R1QlJDQUpOMCtXWUJtWU05K3orQ3k5QUI4ZjFuaTcr?=
 =?utf-8?B?b0JHYVl4MVNVWjl0dWM0MmtqcEJ5dEtuZTRIWUxnbGVuSit6VW1SKzEwWVk4?=
 =?utf-8?B?OVp3cmZPVEFlanNQZXFqZGNseXQ3bnNKNjNFeVE0eFhZa09aOEJHbmozZUhh?=
 =?utf-8?B?VWFzMXBBaEpKRFNxU1V1c0ZLK1VQTTVVWjdhcGJHQTJ4Q0t3dnE3L3BVUy9O?=
 =?utf-8?B?cjh5Z3c3RzBqSkZSQWZwVUtwSmlYbEM5MWdXZkkyblJJaU1wbWt2Qjc4K2RL?=
 =?utf-8?B?UDlXNnVqeUpUY0l3MExIWXI1ZW1uSVU3QkFpL3NuWXRVVTEvNHN0NUpjT3FL?=
 =?utf-8?B?Nmxja1dkVExVMm1PS2hvNHVmdlRLaXF1ek96RnU1bXlpL3IzM0dHRnFMSUlJ?=
 =?utf-8?B?THdNK2JtdlFlc1NjWk8yRDZXdGZrN09KUkxiL3RaUnRMMjJiRnQvajJWWmVX?=
 =?utf-8?B?MEFmNDVNODRzT3JLRzZJYVNyY1BsdUdzSUdYbFY3SFlJYkkyREljUWRCamFx?=
 =?utf-8?B?bmlzOXh1NDYyTFRpMDAzQ3ZrZFp2Y0lqMW54T2t5cXJuSmdmTGE0U2hBbG5I?=
 =?utf-8?B?aTEvRlJHVVM1NjRKREN6dk1VWDFUZlBNZTcvVC9JQ3VuY3B1RmxRUUpnOGxm?=
 =?utf-8?B?RHI5QisxaHVtMnoxYnkrSTM5MXVqTy9VbjVTamJoMjV2RDE5U1dseG1ndHM0?=
 =?utf-8?B?UlV6UkNMdUxINkYzcE9hZkU1WDNjOEsrVWt2dFBhQW9CaWhzVW9HajdPK1Uz?=
 =?utf-8?B?WWdlUGZ6OHoxQW9CNmszQkdvVHR6N2wzRzA0eHZhZUYvb1BRUzBVRkRwSUd5?=
 =?utf-8?B?MGVsOVFkMm9KeXRmNW5vQ3R3Vk90NG1IZDdnMS9kSEtoVVlVc3FQcFFyS3Br?=
 =?utf-8?B?Ry83WVppQlhZNk9lNmdGV2tiWjI0Mm85SFBCM2lPQzJyd0JYV3hBSWxKRG9F?=
 =?utf-8?B?Qkp2amRudWlZRGtna05mK2pqN3BMQ29tcHdiMWdqK1ZHajh1YllJcnBiaVpw?=
 =?utf-8?B?UEcrK3d1UjZKRmpVOGhlVHBaOXNJT3pCaDZuODZTUkVVNE45dzgvVTdGNUFB?=
 =?utf-8?B?UCtRT01KYzBva1VWYW9kNHlkZUpmL1ZPYnkxNjlZZHlvd0ZvNC9JUUp2Uklm?=
 =?utf-8?B?UnhsMmRQTTJPRUFwTkNXMGpaOHE5SXlLbGlBZUVRTW0rY0NXN29ybmZTV0s0?=
 =?utf-8?B?TElYZSs1RzFyWU5jZENUS2wxcE1xZVhpRlRZV2h5bTJOa0ZzcW1CcjRrMVhT?=
 =?utf-8?B?R3ZXUkpWakJjaGxyNmh1M09wQ2xVV2s2dm10NzUzS0dXN3lRdWlVbk5kTi9o?=
 =?utf-8?B?Wm5mY3A2MjZ6K0ZsOVZDUThWQjhOZkJianBaKzJaZ1ZNQzFId1cvdk9McDhT?=
 =?utf-8?B?aWZ1cW9WZDJaY2tIVFJRaWlybW9iekR1UUx6UDdHWU84M3p5WTJ3SU9IMnlS?=
 =?utf-8?B?WlV0UnQ3RXY4Y2hEUGJMa21FNkt2MVQyc3NCVWM3a1dEcGEwcnp5TjZDNGo5?=
 =?utf-8?B?Tis2OW4yTHdscWZXcFFudksrSnAycGtvRFYzaG4zR0NNM3ptQXRQL2ZRSUk0?=
 =?utf-8?B?eURyU3ltM1FjWWRlcVpyUkZNQ3BsUEM0QmVyOS81RVd1NVFFcTViZ1BSbm5Q?=
 =?utf-8?B?SlNkL1V1V2l0QUFaZXBjUDlRbWU4dkwxcEI3Q2IvTDgwYjVzTnZjcUJoTGpk?=
 =?utf-8?Q?tcHZZ8NAQ5NROSJ7YT5Z94o59?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d942b76-8b4e-45de-cd20-08db50993312
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:25:12.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb0aLisM4QWC2QSCLudZv9XZ/QT1ddHJ6nu3SZA99O074ATOQgN/yeaDxQYZ/qpzl2VgxAwz2aljKFCG29zxMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/25/23 8:18 AM, Shuai Xue wrote:
> When a deferred UE error is detected, e.g by background patrol scruber, it
> will be handled in APIC interrupt handler amd_deferred_error_interrupt().
> The handler will collect MCA banks, init mce struct and process it by
> nofitying the registered MCE decode chain.
> 
> The uc_decode_notifier, one of MCE decode chain, will process memory
> failure but only limit to MCE_AO_SEVERITY and MCE_DEFERRED_SEVERITY.
> However, APIC interrupt handler does not init mce severity and the
> uninitialized severity is 0 (MCE_NO_SEVERITY).
> 
> To handle the deferred memory failure case, init mce severity when logging
> MCA banks.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>

Hi Shuai Xue,

I think this patch is fair to do. But it won't have the intended effect
in practice.

The value in MCA_ADDR for DRAM ECC errors will be a memory controller
"normalized address". This is not a system physical address that the OS
can use to take action.

The mce_usable_address() function needs to be updated to handle this.
I'll send a patchset this week to do so. Afterwards, the
uc_decode_notifier will not attempt to handle these errors.

Thanks,
Yazen
