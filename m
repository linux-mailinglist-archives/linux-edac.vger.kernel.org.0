Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A114C0346
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiBVUsP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 15:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiBVUsP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 15:48:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F0CA2F24;
        Tue, 22 Feb 2022 12:47:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gebV6mLA4oTI/AMdhKkNf8USmYkRR/wBlp7nultEBLuo7CvlmoAMAHsK8PF3TV4gyn4/CIhrxywLsG+dhRsXpyqYYkva4a4j+Gvlmu4q6iJWAZI2Ku488WYtpPrlqqy6oelE1Uy/+eZKdAQu8QSbZMI15Dx3ukl5UgvUu1y8Ej8DAYRoSsop6Fwvg9wwGs1lgZIcxNNGhz2wKX18YisYU7PT7WXsc2RpoIVmA9jyw/GdFBrfWbJSbCX6PQjULBC9lOMdsO6YAwT/xwdcADNUtimhLd/nFeDQjtu2pKBioAIH/U9v4YX6q57VCQicwlmdZZzcK4n6+t18gt6EoLfCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1pbFd2aolOrPLXyiOKYcd2xbhG8yXXNZ7NgORodACk=;
 b=iHuIxV+EciD53YOzr5dw81zm0CMeWVT01p/91MtTCrtnlNLO17iJrHkqPWh8oerYHqA9dY0iK9dbjzpi07kUOdLujv/aLP77lMzY9aXcv6Z8e6SgvEh+akkYBsN25Z7je38L9dw0t86unQ3SbrT+a+oos9uQnCb3KAjs2KDd3EuUddUTRE4e9JgyngTuSu52pSePsHzi/Qva1OQO9t/S3l5GMcGF0Cs93jRIOSnfYx3m3+yW9sfTpEn4wAjdtsuKtNO25RlAjl/hTW9NOfGV0//SDCSyLb4klsGRjyME/5r7EA6nHxohyJhdThtzODPT5jBekfgGsC71q0LKLND7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1pbFd2aolOrPLXyiOKYcd2xbhG8yXXNZ7NgORodACk=;
 b=qtsRg7ca6YoVamL+GFZFipdtJT1Y5oc+LoYMHpwWIzXKkbwJDfsbENV2+/p6ZuPKmf7IBIDlqTij7K59NirUhDtx9ml+E6O3JPZOWXPmBKFU5/TRuXL4sXMX6Z/p88cBah2J1nHtR/gWXxihOYib9Td838CCGmJnBegJUs/kiLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 20:47:47 +0000
Received: from DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::50:f1fb:173c:23b8]) by DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::50:f1fb:173c:23b8%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 20:47:47 +0000
Subject: Re: [PATCH v3 3/4] x86/mce, EDAC/mce_amd: Cache MCA_CONFIG[McaX] in
 struct mce_bank
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-4-Smita.KoralahalliChannabasappa@amd.com>
 <YhUC1wW0mxC/Dmpv@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <66a6cc6e-55fa-45c4-1387-ff9d055eec23@amd.com>
Date:   Tue, 22 Feb 2022 14:47:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YhUC1wW0mxC/Dmpv@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To DM6PR12MB2876.namprd12.prod.outlook.com
 (2603:10b6:5:15d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01cdc742-94c0-4a4e-6009-08d9f644953f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4532:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4532FF80DAE0C3D909681AB5903B9@DM6PR12MB4532.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qA4aJ9RJZbWx+LkW483ymuIASWKsaB6rEBwGun7H5AqeEs3cgpFft+yIggIFBZp0eDJHjonGBY/ONp6+MUll2/o5XGJ0AolxQTVPRdbXLfqpQWUOOgoh8bcQ8swsqcVyIWFUBgx2XJpnGER6k5/xMn/YxPhn0XYJXFmhZguSF6SuObgbP3mditkBGUddIHwgKrsQNA8Y4KYZ6Kp6NSzNt+4g8APZtfUDoF1K360GMHsYeUSn+/HQUIUNO8tvb39EJdVlRB1oxShvPtaZR7jA1TwFOvJ1JnRXPhjPnKm7OhgfBBPRsZe+ykaFTy2ZMxTP906dPw+Ufrbb+NzWGeH14I/IQkLCBJDd82MnID5eQ1+hhcLuPPVr+tVa6//jEK1PgemoxgjSAEzfdE357vxRDBDd/VFFTReU+sn9z95VP613AONEiNtu2oRBzHV8/X4rMiMNe1MeB1o6QBw44kjl4jWWdW0y2NWKWTxH60Ej17ztpzDfceJDf0RLd4pQ9Ti89qQyvOA9MsndK2HEEmcwc92sclkoWaX3nm3qITl1QkvfjLE1ujQgQHRzaVsDBlIMavcKH1DPLCc//r2wXePisdqJ7X9M70gBZFcu42KFjvvgLip/ovH3BE4s2GyNhdrv1fZ1ga/LmwooVWvD7ysiGKYdiBYrN30EhvU/eIYjjxof3BXCbGje3D9gxtcZdOXZJ1oxTnxSwgT3XWJ9A8HTevkkLDKdoo9BMU6mfkE/HAgXBRAIYDGvNtd8HdQr2UVs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(8936002)(4326008)(6486002)(6636002)(316002)(110136005)(508600001)(38100700002)(5660300002)(6506007)(6512007)(6666004)(53546011)(83380400001)(2616005)(186003)(2906002)(31686004)(66476007)(66556008)(66946007)(8676002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNaNWNjU3JlZ3pKWGxVd3RFYldEcjNzWFVZdzZQZjl4RG5IVENPZEQydGhm?=
 =?utf-8?B?bjBialhHWGVTejBzbTBwbWt2Mko2ckRxVEdJWHFmeW1CQlpXQjhWTW1sWU1J?=
 =?utf-8?B?M1JiZS9DMzZ0cjNaU0RncU0vdm9nUDNjNjVxc1pwY1J3Z205YnNYNWpYUFk2?=
 =?utf-8?B?K2RmMXFzcmh6VW1KbzRzZStaZWsrbDNiWUVEbWhKbU55a0hVSzlBZUNXTThj?=
 =?utf-8?B?bURCbzRsWnBJS1JocmhNQStCeENWak5PWFJtS0xEdm5BeENkTWNuVTZESHBp?=
 =?utf-8?B?T2wxNnluRis5VWhRUEEzVFVkUHFBak81ZWVYWHZSb29iNnhObUtpTWJneFdM?=
 =?utf-8?B?eXRmeHZMbWxEVUhFazdmVk9uS0JScUE2WEw0MGhvRFp2c05uRnRWMU0rK09T?=
 =?utf-8?B?YVVaa0tPUk5iSitST1NSUTZmSGROWi9vWmZFTlh1bmUvTzNWQ3RiOWVjbDNW?=
 =?utf-8?B?UFkzZmxEM1YvMEE3Yzd2WlZnZ1pjMndzU3VlVkN4NWhrQm5EZDFJTUE3U0lN?=
 =?utf-8?B?YzFLYzZTMk56ZzcwUTVQVlRqcnBIUktqQzhXclpwaGJmYjZqZmZWNUl3aHpn?=
 =?utf-8?B?S1Q5enVWZ1A5UE9iNHNnSFB2aU1qNmhzNUoyNHA5N3NLZmN1cHcxS0wvcXVT?=
 =?utf-8?B?MTBGeS9IWWgxaUM5VDBXL24wTGUrSG9PZVlOb2QySXRvWUlRSG5UdXdjdXhi?=
 =?utf-8?B?c3Zac0NOZjdKd3hPU3lCTy9lYm9tbzEydUh0UnJvQmpaWU8vTEtheVFpdm00?=
 =?utf-8?B?dGZ5S2tMSEZQU2hrNjJyV1VWYVFqNFpUcGtHTUdFWDF4OWdVMndDeEE3clJU?=
 =?utf-8?B?KzBja1BxTVhWUG5TeFRBRFdRbHZmRFRRVEYvdDB1OWl6cFI0S3M5WmRjT1d2?=
 =?utf-8?B?YUFHaE5BQVUxS0V0SWkyZmlDNGhjUXRoa0pXa245Tk80aDNlWU94U1FaK0Zy?=
 =?utf-8?B?STlHTFdYcWw0NU1mOG8vcjNMM3RZN0JDQi9JZ3Zjc05GMEZkcEdjUlVlUWNL?=
 =?utf-8?B?ZlFrWFpzQVJ5QkFTWnA5V3JnNzRuVnYwV0JCNC9OeHZVVWQwL2dsNmsrVW9H?=
 =?utf-8?B?LzdBdFhiSklrRDM4Zml4UG11czVyZGxaNXoyRGh4K2JFRFA2bEJYRFQ5aFVZ?=
 =?utf-8?B?MDh6N1FWdDRaMzdEeERSTUhHNWxYb1R2ZER4SVBCeStObWI1V3dQeGkrekRL?=
 =?utf-8?B?d1JIYlRJT0JscGNYRXFoMTdxQ2p1bytzZ0pmZjZtbWZYL1crWndnU3BIako3?=
 =?utf-8?B?bTJrWkVWbEFaSG1BRGVJUGFPK2ZUVlVQSU9xbUFxM0lRUUNLcWhWR1Mwd1Nr?=
 =?utf-8?B?VGpmWDNHQWV1Nk5hU1kvWE9nZWpmOEpKcEVsWk1YQVdiQWFsOWtzMlM3b1R1?=
 =?utf-8?B?MFZPcnZsOUpnNVJnL3dMb0pMTGxGbXB3OUxsbjB2NkJOZTA4bXM0NjlRckhU?=
 =?utf-8?B?bmF3ditiRDRnT1VxdTJtNE9OQWplV0NHaFY1VlJlcEo2MEpwRkVtUE8xdTZI?=
 =?utf-8?B?dElPYnBtUDFxVURLd1NnOGwyVml5eVZ2QksrZk81dytzeGZya1JabWI3b3V6?=
 =?utf-8?B?RDBqQzgzTjg2T1J1dTVBaVcxQmNOaUNHRTFiUFltQ1k2WHNaQzRUWlQzNUFp?=
 =?utf-8?B?RnFUMkQ3aWE4U3hyaUQzQ0h4Sm5KcFFBbDJGbW9nUzczb0VMUTRTTE5naHBF?=
 =?utf-8?B?d0NieDlUdzUwV3NoalQ0UFZ2NXRBbC94WGptQXc5T0dvVzd5SnVQdXprR2gv?=
 =?utf-8?B?VFNHT3RYbWhzYjQxaUVhdzkrdUZsTXJ6blk1ZFJySDc2R2tWY0trRDBuUENh?=
 =?utf-8?B?S21wME9QYklvSnlyWkpqNjRBMXJmdWhkbWw1cjQzMkI0NnVpbjhzUmpMc1Rk?=
 =?utf-8?B?VHpldmlwRXVqYzhmNndpK1BWMUZhR2cwSmpiQ2dCWVdNRElKYm9XSzlIWHdz?=
 =?utf-8?B?ZzNTU1ZoYW53ajVsUkZHRUhaait0WjNGTmdxN1V2ZnkrWEdWWHNQWDduUmVk?=
 =?utf-8?B?SnBzSTd6WW82Rlo1SnV1SjFGRXVVTWhGdC9odFRSWUYrcHA5dm5JZjdIakpC?=
 =?utf-8?B?WlAxS0tVaFRDWWNyVHRjN2hsRmEwb1kxRXhhZ2NFTGVYMEF5cGdrVGpOMGlv?=
 =?utf-8?B?ZTBtb3U0cHlGa0VkeEg4ekM1a2IyY2ZodnZSOW94RHQ4U2R4TjVJSWdoRXov?=
 =?utf-8?B?akljWHVxaStXMkMrNHMwak84VVFESEpqTDNkWXEreUJQa2pPU1RWNTJCVXQx?=
 =?utf-8?Q?00Rxj9AGItIx0IcOVBdkv54HJv3+Ft6S6tv5NWHgu8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cdc742-94c0-4a4e-6009-08d9f644953f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 20:47:47.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+mOLRgDqG83fwFkNNrsHypShgbsH1fg/yvJl57OwmzGH5Iol2tinXsZi1bcGRO5Sb6a6jkgr0DYQxbJ/K1vzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2/22/22 9:35 AM, Borislav Petkov wrote:
> On Fri, Feb 11, 2022 at 04:34:41PM -0600, Smita Koralahalli wrote:
>> Cache the value of MCA_CONFIG[McaX] in the existing mce_bank struct
>> similar to MCA_CONFIG[McaLsbInStatusSupported].
>>
>> This simplifies and eliminates the need to read MCA_CONFIG register each
>> time to check McaX.
> I don't see the point for this change, frankly.
>
> I doubt it is speed because those are not really hot paths.
>
> Code savings ain't either: 5 files changed, 36 insertions(+), 22 deletions(-)
>
> Having yet another exported function to modules if not really necessary
> doesn't make it prettier too.
>
> So if there's no point for it, you can simply drop it.
>
> Thx.
>
Hmm okay. The main thought to come up with this patch was of course speed.
The speed might not matter much when we are trying to configure registers
as in mce/amd.c.

But what do you think of severity? Will this make an impact when handling
panic severity levels? .. mce_severity_amd_smca().

I can drop this patch if it doesn't impact much.

Thanks,
Smita

