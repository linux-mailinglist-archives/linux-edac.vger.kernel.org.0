Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1CD4E5528
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 16:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiCWP0K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiCWP0J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 11:26:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859F1A392;
        Wed, 23 Mar 2022 08:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMqT2xPSa0xyRLX62OB4xYSrFAQ446kUJ7aQdMQoVDtC0ZvdJwGnRgggYZ7SYlDsJ6QxEA7opUo2lWJ2ZpjdIM73CxL9pnmWB/ubqvgH38fiq6LMuoVjtOq053Z4jKxUg36WyoiUDdXcdDoBtm29OTFKilE8cmXmViT8+wD9/jZhGZbBBzMCUuq9181JS7veCi0MoLiAjh+mOQc9Oxlq9ueq3DZo6iSwpWgI5ce8g3a6ubWA99ZLZjBuSas7IZ8UATsdn/wYy3TH4dNVSrPlxC6kD64kUcAxYpA/2OGcsbTQPqefU7fKlxUxZ2nsLecbo0/SKsQbH24zCTFB1P7Zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVBDGugAAG5mcvYQMO55LTjjccNkvOy6NrKoX2lj6ZA=;
 b=l7XtbK2k8I/WrIDR+w0wL4kHe1zfKaUqe/px+8UV/+eiwSID/IouPCDHkAS1jvk3xCFTNZ+F+t7HTOg92eHbLbaTqCPit8UtOHkp1lgPsVVeZY8OvIkzQ6bga5LBEMbBdUF/6ZgQDZIGgOr1XIB+zuG3k8PYZZqEFuChXDk7RAz/+Bei+pHse3/1M+IbX6H1eG+qdjuHIdIf8Ttiaz0KKGrOeVZdDG6ok4TT+eMfvrmhDZMBJQy2WK71rjD7+RyF2PkwzvUnW5Ld7moPSdwHkcLShcfCa0AQZkZkBgpZhQ6VNcE1iuPiImaPsNr6QxJsQkq1Go1RHd0zN6hNN0JteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVBDGugAAG5mcvYQMO55LTjjccNkvOy6NrKoX2lj6ZA=;
 b=bThcEhKZyQjmlCDZtWmpWV1Zh9i+OIi8w+XW0xV9L43DdNUeW+5NlWzlrCnFTFa/U6fh7381JIgYtofmYJEdw7IhwQPn/vhVs7Q7hL+XVSlspgSdLedRJIg5q6lXAglh/qBr/WLbCo4kihFSs5F7jt6/xDT4Y8QXYOb+r6TbE1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BN6PR12MB1860.namprd12.prod.outlook.com (2603:10b6:404:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 15:24:34 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd%9]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 15:24:34 +0000
Message-ID: <31759627-1754-8d5d-6d6a-df3010d3e8e0@amd.com>
Date:   Wed, 23 Mar 2022 20:54:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/1] x86/amd_nb: unexport amd_cache_northbridges()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        airlied@linux.ie, Muralidhara M K <muralimk@amd.com>
References: <20220228161154.54539-1-nchatrad@amd.com>
 <YjDMvYOh8Vizq4xv@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YjDMvYOh8Vizq4xv@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::25) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51b64bec-47e2-42aa-7fbb-08da0ce13c22
X-MS-TrafficTypeDiagnostic: BN6PR12MB1860:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB18600B79CDB6A1622D0D9C19E8189@BN6PR12MB1860.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJ/AtvKYyDQSaYXzV8vgJUWvzqd7yDFdHwLwIVeozq9Eo+DyfPXcHfXBVUDy9Ym1+TDZYYuDZYK2etkB3pz0hIu6yS4FCbywPc7Zaw9y3QlE2x4B30nZuwAozD+obi2vXyuPzVUN8frH3Py6ikJht8W+Xk1EIZ1Q2D8c8fwwnwfJO4IkQzjUwjNgOdIiDD1hEP63shQzKIcn0X5dgbBW1b0sgtVcQn/QjIZw5JBWOdmFSbFqkoQyI8NcAFtVuCT358jT0USIChwQbhuTiegXYVlsHqRM8rL4h0q7+F1QNWaD6UJO6Svg0KhHcvrVa527VkzfwGRga6LPb/dr+C9tHOEQlzvOhXU78J3KuPn+sGWe73Z6z2/cSfXTthaAbsEF6XIRfXtGgcwcwQTQai4q9auBqGDP1p5MIlDhON816psMZ5TLx19REF8pIFVz6fR4i/7sJwqxR4eKGtupf0okKXN9LwR7g6hKxfRP033+/b3+90k2v1JvGOoEQHkwdNGaWRZzPQIBIU2i8HRh9QSYyGF/RiFdZ3ebZpOj8Osl8hsdbYjAKCUC3eE01ZkPX/Tsf207BkxMSFvMufjbLg3YfqVUXrDrxCupXdwAv5tGWy4Hhccs7fex5lcx2+t9Qr5ixY2wLVQqWlWU2ecpdYNtPwSbP54CtyV9tD8GI1LRGYJup8bvUDp+Jed4z4xyfRsjFJIAE8YvAejId2cLS8NMi24nXXwiw5MsFcN5LVs3r0XsWxigb+M7UZXeVaMklwDB4flCY/oSmGiSqnOstfLEZJtfLxcbxzgC/9ALxRvGNEJudSHbQYFgnRlE0aMCndqfviDcOg1+2liG3AHaiqVGoRUhbPwWuogN/855maf9nAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(508600001)(316002)(8936002)(45080400002)(31686004)(36756003)(38100700002)(66476007)(4326008)(5660300002)(8676002)(66946007)(2906002)(66556008)(6916009)(83380400001)(6486002)(966005)(2616005)(6506007)(6512007)(53546011)(6666004)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdRZGNVQ0dDQkRSUDFuUmZhOTZOdUZwTkh4YmMwMjJwUGNGdTRtZUpyNit0?=
 =?utf-8?B?TExKaXY3ZktCSjh5dHZKNDVvK1pnZUFtenZNemdtRVJhbCtCS2RXUVA2YlN0?=
 =?utf-8?B?N1A1U0ZydGp1OTVucGk5WG4yVjBreGVHZ2FYalVqWG4zM3k1aSsrV09CSzB0?=
 =?utf-8?B?TlRWYWMwODlYMms0TXdadkZuTWg0OE92UmM2RFJmMU5QRmRQdktmQTN2Vjg1?=
 =?utf-8?B?cDB2c1gwa1FrWmFnSXpTMGsxc0N4Zjc1Y2hIMVVRZVpzRWkvaHZRWTRVTzVD?=
 =?utf-8?B?V1lKZU1YTnpXaGdmQ05VN3VZbk02VkM2SHJoQ0JueTdLU29uTkdPdmV5Sldw?=
 =?utf-8?B?SjJ0cUo5Sks3TzVCMlE3Zkg3aUhUSUtWSklxUi80WEI1WVJNZFVuYy96TjRy?=
 =?utf-8?B?NHR1QjZVZkNsVWMrUVltUEFJMG9hemFzMDk2WEZSekd0ZXNHSGRTR29EWnJQ?=
 =?utf-8?B?OG85UDMzWnNUNThaMmNjMXBpcDgwQno3N2ZKZUVodm1LTXNndEJYaWJhQk5i?=
 =?utf-8?B?a2k1NkIvUjBWOERuWTdnUHljSVdJcTg5cXZpR0F1Ri8zZVUydE5TUlJNaTdJ?=
 =?utf-8?B?NnIzU2pPNlVubHljYTRaeW9jVk9HVEZHei9Ub3hhZnBGSmVaWkd0Y2thbFIx?=
 =?utf-8?B?YmE0MUhBUXZjc0F0WGRCWEJzSHQxeVNnYVVBeEtObGpFMlNHd3lSNEVWSXhj?=
 =?utf-8?B?TDlPRVZzNUVUWUJIU3ZxK1U4emxmb2VTcHRWZmVQMThwMEtOS1p0RmF0VERL?=
 =?utf-8?B?MkZrMmxLdlIyTmlKbUVybjFjSTh1MkhWR2JlNTR3c3pTMjlmNUlHa1VadUUr?=
 =?utf-8?B?dTRUOW5vK01xeFJTZnN0Ny8yNyttbllOOE9PcGhZYlc2bE8rTC81T2lyZUZL?=
 =?utf-8?B?dEhuY01najZ6dE1BcnFyVk1YVnRvMkFlNVZ0OXJqY1dRL0tMa0ZhTTB1WE5X?=
 =?utf-8?B?L0JkRWp1cWhCSWF2M2J5cmIrdkhPZjY4NTRzeXF6U2V0UFpaVlBKNllUcU0v?=
 =?utf-8?B?em9OT2EyaHhQcmM4OW8yTDR1WGZDcHB4VWpQR2hBRUpmaG45Z1hxeDdLZWlY?=
 =?utf-8?B?SkNidWFpYThUUisvTU1Yc2pDOFFOSzFxaVZRVGw5aUZ0WEVseUhrQ3FhNEZo?=
 =?utf-8?B?YjVET0NFVGVDRmJrd21LQm1SWjlvL3RZNjllcXN3QWVkNmtnRjgvUXI5V0xI?=
 =?utf-8?B?VllEQ2R0Y0ZLL1hyR0d3cDJHQ1lpRWFsMEFxcEVRWkNRWGZaemo5Vml6Umkv?=
 =?utf-8?B?OVdOMFhmaXJqMGt5MkRMMnpybWN6L0FydW5vL0RxLyszVm9RQ0lBNE56RHBX?=
 =?utf-8?B?N3NYT0ZGM09IcjJ3SHl0emNwNHJtRkNpbHUrNVFhQ3BLZFduTmpkVXRBZTM0?=
 =?utf-8?B?VlZVUTdzK2pHMWN6L01NdUxqS1Z6L1VOYkwzNlZ1bzhBNGdHbmF6S0srejR6?=
 =?utf-8?B?WkJBSnJBYUJUSzlFQ1haOE5sMmZZZ3R2Rmc5QVc3SFRXdFZuK2ZxTjV4aVZ0?=
 =?utf-8?B?SnRsOEU5a055clkyWnVCZm5JMlVYWG43U0ZINlNFMjZwS1JzVHVKd2F3dzlO?=
 =?utf-8?B?M2t0bFhGcStCY1JuOHZlS0RGQnNMYzh5Nlg0QXdjS2Q4S1R2NTBHTG91amE1?=
 =?utf-8?B?OER3UWRFVmhqcWpqWHlLSDNwTWlPY1RLd2dvZ0xCeVA4V2NNdkdvUVZaMzFU?=
 =?utf-8?B?UzlpbWx1c2dSREpBd1VMN2lFc2Y2cXl0M0taSGhHQUZMNDdzTDRxTWplNUFR?=
 =?utf-8?B?azNDcFdNNjBBR2tGdElzNSs4L1N3bWsxeFY4eWVONWs2WWNCb3d4QkRjS05W?=
 =?utf-8?B?Rk8wT09lWFo5RVExVGFpVHlYcFpYNlYxSnNwMGppU2tWOWpQK3RPcnNiMjFt?=
 =?utf-8?B?aGdkUUl4RDFCRmR3RW45akZvTGF3RnRWWDZJMHV3QUV1dEI2SWMyYWZJbDEr?=
 =?utf-8?Q?H8lZNKSa5SjcvOHlp1s15gbPtcIzcGYt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b64bec-47e2-42aa-7fbb-08da0ce13c22
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:24:34.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTRvw9urVgpbFeIlTvOGJko//NPWnyXCo58lnxeXdORZabCV/gOz0ytbdEepz/TYwlD5p0D5RMAAXlWb5HZLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 3/15/2022 10:58 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Mon, Feb 28, 2022 at 09:41:54PM +0530, Naveen Krishna Chatradhi wrote:
>> From: Muralidhara M K <muralimk@amd.com>
>>
>> amd_cache_northbridges() is called from init_amd_nbs(), during
>> fs_initcall() and need not be called explicitly. Kernel components
>> can directly call amd_nb_num() to get the initialized number of
>> north bridges.
>>
>> unexport amd_cache_northbridges(), update dependent modules to
>> call amd_nb_num() instead. While at it, simplify the while checks
>> in amd_cache_northbridges().
Apologies for the late reply.
> What I am missing in this commit message is why is it ok to do that?
>
> AFAIR, previously, amd_cache_northbridges() wasn't an initcall so the
> module or builtin - which came first - was forcing the NB caching
> through the explicit call to amd_cache_northbridges().
>
> fs_inicall() does that now unconditionally so the question is, why can
> the module init functions assume that the northbridges have been cached
> already and can simply get the NB number?

Modules that are using this API comes after the fs_initcall() is called.

This patch is prepared based on a previous discussion

https://lore.kernel.org/lkml/bcf5e86c-d3f1-0dab-2bed-505b1eb95f17@amd.com/

quoting from the thread

 > I'm going to venture a pretty sure guess that the initcall runs first
 > and that amd_cache_northbridges() call in amd64_edac_init() is probably

 > not even needed anymore...

and i've confirmed the call flow.

>
> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette%3Awq&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cf178536c5a264e5bd9ca08da06a98c6f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637829622545040298%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=iRnHksY7p4nd4pALbDNp11Y7%2FSMAou9X0XrV%2FC7K8Xk%3D&amp;reserved=0

Regards,

Naveenk

