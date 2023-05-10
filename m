Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D36FDF64
	for <lists+linux-edac@lfdr.de>; Wed, 10 May 2023 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbjEJN74 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 May 2023 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbjEJN7v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 May 2023 09:59:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D8D851;
        Wed, 10 May 2023 06:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux+VkgvXMhGZKbG7r+j10Emp9VSrONIA8FAanPCCQJ7a5OAoKC4SPt7UbQJU4ISNCzSl1X+kSGgJ8FPvFa/K9G05+bW0/7V0yBUItp7HhBKI1TcIpWxHVITz8CdS1AhA1+r2n1qj5+Pqs2EQV8I50Xt4MjnOqukcsD+Qx7SoAs/Yy7w+gN/q5XtDOSVxAUUTXrqZt2AR5f0mG+oXpBvXgkcrqo4DCLuQP2l1ZkNVRJC0Rz63vLr0MCYxARglNx+ItghAhBh4B8tayZt94ZZ5/LMm/2trHeJLPMMwdgZYV2uvmCTEKDu4NAVDaRMo/WAvARhnwGWkUZGQv9F9K71XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPzfHOXfcNgaZXBQBJMwdTvsLtU8Auogja8XeWV3V/k=;
 b=dbsEHD0Zf9hmcLBjbLnf6ZtqqTznzm11/ekesJT53Pbn1PsVS51U4MfZeNztZvIZwGeGNg1PNXMgtSIrPQWognLOy5qKehXorh+ceIaU0i2mBZRVrXbArkv9a0P0SQxHJrhAfPK+HYUFjn43hgwFTi4/n2YsCP/MJpAQdT0r7RSyvToTmTpJJigf6EuZnQm6eN+PlEvIZXpRSdRYtTyRk9KOxE3+aPK+kIeaBpTQC/goWUFiIA7B14eHh0C0SyGpqPF4rZnB9fv5GawvK0B98Y5Li9KKl3ZAViRu6cWRi/NBzbC2OwIxDpqCeY1tah9bgAz4aVTGIiDqMJgaMQxiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPzfHOXfcNgaZXBQBJMwdTvsLtU8Auogja8XeWV3V/k=;
 b=irC2gAVGcfKb3qKWdtUvScEJq59YwmB9sOOyEJKrcjN+r79pu6nOXBL0IlVK7WThcLblvJ7OmvkT/AmruaQn9QJ0tIJrf7vVGIQMnKCWwSqE0BpjENRTPwQ3s/PjvXYpfvEIBnsqDnQTAQexXmRV8jUnz/nZgA2Ppp5zO9jbKP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 13:59:39 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 13:59:39 +0000
Message-ID: <34fa94f5-359f-f3e7-92ae-fcdc06ff19b8@amd.com>
Date:   Wed, 10 May 2023 09:59:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        baolin.wang@linux.alibaba.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce/amd: init mce severity to handle deferred memory
 failure
Content-Language: en-US
To:     Shuai Xue <xueshuai@linux.alibaba.com>, bp@alien8.de,
        tony.luck@intel.com
References: <20230425121829.61755-1-xueshuai@linux.alibaba.com>
 <f629820c-50cf-7366-975e-68215b3f2bc5@amd.com>
 <b384d621-6b2d-7aab-adbf-7045f23f4af9@linux.alibaba.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <b384d621-6b2d-7aab-adbf-7045f23f4af9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: a237b6dc-186a-49d0-6052-08db515ecbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiohezCamk19d0IbDpkTp/GLuO/EIkeSpo09cYMfZmPKYupWAsoJRVn7wI+aZ1ltlPfH84zosxxddL26DdwFMnPsRQ/jjys6lKd2yji0pY9BObt9fGnZCUEWMYuxeeBrfclzrREp25kH1DP7ar+TU3woYfip51ni/bh7THaewgJYLW8UyPU/ZJhjGwJV4LkG6pFSzMIODck0QCiooWpPyLVUn7P2kx3oTtD+G9ug5Du/k1AG5FD3hVT69rgTwBE40mbSBLjommZIXOOCzBZ08pWE/lgKFiJTqTm/ZvqAADN1zIGf3WrlwOMFAHKftauF6C09QZ83dI1vjRYD4D/Mj1+Ast8INAmYWXvALyYB7KmLxBTZeq0jh8c9Khvzu1dcaZIMgsLKmuUHUe6Mz6+eXDH3Orqi9aDJy1VOYxd/dbPCuEk/LCcWwwAshKprTJa6dQ0MTXxI4CHZ8RYVIBHGAaTzMC46bXs+qHathxTP9nigh986NRXIMRpy6oVVbLNBOSKqYrlva93oNpYLLos6TXhSDM9puF25FyK9lMoXGG6Ep9muMgvOOburp9OPvnOamhqpsaepVUk7zVNccnIA7EDAYdJNnvYvO3qwnYmHuczyawn/P8BEMaSe6eN4670QE6Raail1hdjdG1H9uDsUgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(31686004)(4326008)(66946007)(316002)(66556008)(6486002)(478600001)(66476007)(31696002)(36756003)(86362001)(83380400001)(2616005)(26005)(6512007)(53546011)(6506007)(6666004)(7416002)(8936002)(41300700001)(8676002)(5660300002)(186003)(2906002)(38100700002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJGQWdKRzRYSi8xTVRONElPUUwzbHV4eVFRR3VJcEhzNnJyaFJrK2VIRzVN?=
 =?utf-8?B?YXE1T3lpckk1amJtbU8xbzBrUEhNMnR6UHdOeUxtMlZCM25LVkZRazVuRUdG?=
 =?utf-8?B?Q1dJcXo0V2JtRElSaldSTDdiTlRMbnVJYUFzd3B6bmlqRTltdzhvRVZkcEta?=
 =?utf-8?B?eUZRaHlFTHMwQ2VBb1VYd05xcnRIS0NmbEV2Rm5rTldKSm5mcVdEWEJNbk5N?=
 =?utf-8?B?U00yZ1ZwTWhTbkRUamVoRWdha2RZS0NXVXF0KzBvajI4ZDFzaUVUaU1HOXFw?=
 =?utf-8?B?eTBuYTRFbWhPLzFxZTMydHVpMkprRXNtbTV4UzY3T2FpVHlLdXA4R2hoVWpE?=
 =?utf-8?B?YW5MRXB2Rld0MUg0MnF3RUNyT3E0T3Z4VlpWUWczcEdaWFJXU0xKNW5jQTl3?=
 =?utf-8?B?YnRlMk90cFlKK1BnVXpTbjlMcDY2amhLSjc0S0NaekFQMjdZaWo5ajVJMWJl?=
 =?utf-8?B?Tzh2SVBrSUhoSjJsWXNuRGlCSTNtWDkzM1psZHV3TEhxWW5EbGtuZE5vdCtt?=
 =?utf-8?B?Nk9RN1I5cXRsYUx5NjdwK1lCYTV5enpSTCt5VHRBRDVScW14T2JKTzQweUl6?=
 =?utf-8?B?eWhyY1R0K2JHT2tUSDF2RmsrSk0wbUZ5SUYwMzR2ZVpUcm43bFIzQnhUenBx?=
 =?utf-8?B?ZURpQm01elhyemEySzFpcVlGeGoyRGdwOWNGOSthcHdrTnIvUUszUWtNajYv?=
 =?utf-8?B?VXZJZUJWVG10WUhvUlEzT2NYVmFXQURtSkx1dUZWOU5ZcHVENEx4M0hVZUZO?=
 =?utf-8?B?aGNldW10NjFtS1FBNHR2dDFUUVZNcno1RUFPQWhBb0xLRnBrdXlHK2I5L2ln?=
 =?utf-8?B?d3hwT1JNUTJkYXMwbEVwcVhZSjY2UnNiWjZuNmFCcHpmdytvUm5yQkFoT3V0?=
 =?utf-8?B?dGtjOXBqSGkwQk1EcDFyL3QzN3g4TERtNjBkRkZEZk9BNkVzbTNlVzI3Mmsx?=
 =?utf-8?B?cTJzN1F3dU0zVHpNWjFIOVFwL1E5enM0UGJtR0NXZWJDZitoQWsvbDd3allX?=
 =?utf-8?B?TFB2RFVFaHByNWhNaEtlM2o4d0lsYkVyTDZIN251ZUw4eFUvdTVLTjQ3VXdV?=
 =?utf-8?B?ZTB4NDRVSmYvTEdqSjdnOEgybmpFbnFKMDdKTXhydFA4a2JFRW5QUUtkMmw5?=
 =?utf-8?B?Ni9Rcmc5SXlQU0MrUTRjaEcrdFF4UVJIL0lnMEw3eURwU3dIdjdhbThkeHpl?=
 =?utf-8?B?VHlOWkdtYlRmM2dtZ2RIa2lqNUVITldEajU2NDdtYUtKb1NBaUFvUmRaSzFo?=
 =?utf-8?B?M01jT1R1OG9OREV5OXNRdUNHUDJrWkJSWlVlVmZ2YVdXalNCZjFYQzFBTFJP?=
 =?utf-8?B?b2ZrZWRrcUovcWxmZnhjQkJrUVdWcklaK3I4Qk9zQUQrVHBrc21KNlFoV213?=
 =?utf-8?B?OHhOSWE0Q2t3bThTd3hyeERPNVpDZHhiMml1MWZZRE1EMHB3Mm1tdkxpWk9H?=
 =?utf-8?B?WTc5Z1dybGZnQ3pVRDY5Zjdsb1dpTTdwRWVHZG51aUhocDZJY1o4bUg1ZnRF?=
 =?utf-8?B?NEdNZHZtQ2I4V3MxcTB1ZFlRN3F0eFFtbzRtcU14L3JLWnFXWFNjcSswZzN4?=
 =?utf-8?B?dnlDU0lNa1BLZ2ViV1A0azJ5ZzN0aFdzQUV0YytuTGRCdGxqUzFBWCttRFBi?=
 =?utf-8?B?enNMa1FNaURqWVRTYS9OalJYSW1zd0E1b2xJdUxGSG9IWUNJOEEvV21Jd08w?=
 =?utf-8?B?Z1Zqa2pzS3ZHdEcrK1NlMDVLZ0NQSDZseGRKN1l3ZSs4WWkrR25mczBFUG1O?=
 =?utf-8?B?RkpCU2EyWW1sVkVoazhEUHR3ODc1VFJWTk02VHM1SjArS015RTQySjNSRFJh?=
 =?utf-8?B?MzFhbnRmT0E1dFU5azR5UytQZlZ1a0dHTzNLU1l0TW9SSWJzWWNUSXdMaGdx?=
 =?utf-8?B?Mm5NbVhXb2srTG55bTFvbWk1WXZqWGdyVkU3MU9STTFrZ1d3SjlmTkszeU1L?=
 =?utf-8?B?dDFLdUdodW1HRndZU1d1RlhsVm4rWFJrRVQ2QzRsYUxOWFFIbDkwSW9vMkRY?=
 =?utf-8?B?ZjIvN0dBQ3JkTEJsUDBEVXNRbTB0bDh3OWllTHp6RWQrblVYenRnM29BYXNi?=
 =?utf-8?B?TlpDclI3aUxOenZhZnJ0MkpvaXFUUW43YWpxWFUxSXlUZ3RjU2VPeTJzY2Nx?=
 =?utf-8?Q?gOEQ4AvcE7zfSZ4ulmPuGH4w+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a237b6dc-186a-49d0-6052-08db515ecbef
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:59:39.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnfRRtSWSD8k4w5zwvLGpK028sR5s3kSTfStVrobcf+GucnblcJMUdgvrK4awuCBwoyPGzw4aoCl7sPFrcEeZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/9/23 10:17 PM, Shuai Xue wrote:
> 
> 
> On 2023/5/9 22:25, Yazen Ghannam wrote:
>> On 4/25/23 8:18 AM, Shuai Xue wrote:
>>> When a deferred UE error is detected, e.g by background patrol scruber, it
>>> will be handled in APIC interrupt handler amd_deferred_error_interrupt().
>>> The handler will collect MCA banks, init mce struct and process it by
>>> nofitying the registered MCE decode chain.
>>>
>>> The uc_decode_notifier, one of MCE decode chain, will process memory
>>> failure but only limit to MCE_AO_SEVERITY and MCE_DEFERRED_SEVERITY.
>>> However, APIC interrupt handler does not init mce severity and the
>>> uninitialized severity is 0 (MCE_NO_SEVERITY).
>>>
>>> To handle the deferred memory failure case, init mce severity when logging
>>> MCA banks.
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>
>>
>> Hi Shuai Xue,
>>
>> I think this patch is fair to do. But it won't have the intended effect
>> in practice.
>>
>> The value in MCA_ADDR for DRAM ECC errors will be a memory controller
>> "normalized address". This is not a system physical address that the OS
>> can use to take action.
>>
>> The mce_usable_address() function needs to be updated to handle this.
>> I'll send a patchset this week to do so. Afterwards, the
>> uc_decode_notifier will not attempt to handle these errors.
> 
> From the experience of other platforms (e.g. ARM64 RAS and Intel MCA),
> uc_decode_notifier should handle these error to hard offline the corrupted
> page. If the corrupted page is a free buddy page, we can isolate it and avoid
> using the page in the future.
> 
> In my test case, the error is detected by patrol scrubber in memory controller.
> The scrubber may lack of system address space perspective, and only reports
> "normalized address". But we can decode the "normalized address" to system address
> by EDAC (umc_normaddr_to_sysaddr), right?
> 
> (I am not quite familiar with AMD RAS, please correct me if I am wrong)
>

Yes, that's correct.

The address translation requires some updates that are still in-review.
Afterwards, we can investigate ways to use the translated address. It
may require some rework in the MCE notifier chain or, more simply,
calling memory_failure() from the EDAC module itself.

Thanks,
Yazen
