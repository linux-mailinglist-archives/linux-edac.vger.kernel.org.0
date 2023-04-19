Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327746E7A4B
	for <lists+linux-edac@lfdr.de>; Wed, 19 Apr 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjDSNIL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Apr 2023 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDSNIJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Apr 2023 09:08:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7BB9EF2;
        Wed, 19 Apr 2023 06:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co0Kr+Z8Aj36LDmf1ZpC2iipB/vDe3URusGtZkoLmfRkASsbQ95KmbU7qRSun1sTV/FQNaWQ6Dbp8xXiVX0fxg7V/l5eoe2vT2z3RKwhO3hIqGKm1JorzNgfiKzrj+bmSy9A886pJ2kfxWP7Xa3pYITL3LJfPa9ys7wyE9thMUdLzpjc+7D4hDROKmXHbYxdkVj+uEoV2hjRf0OevK3B/ECsq3I/jdsSj2kvPODzCKmrynl8hP34YYyEf17pQRWF9pVJgilPdS2LvVucIxf3X0p+66KgBggTJsnGSiGrMdvx9zM7UxxBuCsoVhr4jY1GXv/UCx5xI0dO/8yVEC5ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJOWIXxwxL+EEKdFdZm+AVbjNp1kUwNz/edItKkuqiQ=;
 b=QFWlRzblAaEUu3VbFZnQgSdz29jFBsq3jzd6D11+nNi304YEqddCdu3DjSXXmDQvj6wytQAZtQYr9dSiwme/caRtxRFmpv0EioVB5aVHL1R4guWLdCPq6c7fBCurSPGlRVjTkZfgqe9F3RzL/IOluqb830w2DLe2yO0TujfHLJGYiY7+jJhXvHQGR681jr3HKqXj90oX+Uwv8l32sAVX8/pxCz4lDih0ubIs1QP8C9wdRHdgAAawMeAoY3V737HKvRTmREY5dX0RfsynTclo+5wuIYE6IF4fyGaHgawefItygyhkVopN9RCXtlx3yrx4pookFQ86V27igiwIkLKjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJOWIXxwxL+EEKdFdZm+AVbjNp1kUwNz/edItKkuqiQ=;
 b=5EpOABuEjc3mFBOlWEk1+oQkH81S6ZQq2nqEVk9Q7l3h9i/aaOv+VVLEVScwYZs95++Fy0jYjmqPqpXj7uy1keaytSpq71QucpQp4WUqhLGcoeBIsmzdHUU0Ji28cnQBA+/Zj9ZcWvkvGk0qug4NQcUsV2zO4VzSFT73yudlIig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:08:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 13:08:02 +0000
Message-ID: <0bf7ed90-7231-d280-fd52-5906d693fbe1@amd.com>
Date:   Wed, 19 Apr 2023 09:08:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2] x86/mce: Always call memory_failure() when there is a
 valid address
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
 <20230418180343.19167-1-tony.luck@intel.com>
 <93d0e5e9-eec1-cdab-be5b-cd65f792e5ac@amd.com>
 <SJ1PR11MB6083BF7037C9C86E097FCAA0FC9D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB6083BF7037C9C86E097FCAA0FC9D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbc1256-0a37-4f19-41ef-08db40d71b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9C4PibeIWQlJq8Yw3Z6AKB52CCHJHwAbYHzjWTdiMV2vU5PZRLh6jL3Q1paL6qgN0pPnGCF+W2EiKxj5/LY9SVveO3fyh7ZlVKXJr5ftAqfyRgpry8pRjSpRjDkrcnvSfhYbJecM7fbW7MIKJY5jONDNGJSuLmKwyzgl/x5WnodOKj4WuPzZbLp7tdQmIvP+T1OxBUL8vXKTBB0dWNqz6jOJq9ehxnkdWSwEPvS63xVp6sCEWDLqdrK7LIRLLFRC1CHt2KOnpm0Orerd1E+p9Ta2DLgQutsjKZKpYUQB/JVCkZWNrDJqoVWVLaXYYOkcQ5LvCIjK1ZQ6xWwGjvtLZ2ApgWI2agtqzKunuzKR9bhxXB12nmY9Nk3DmxesIqAkLTOLxFKiYG3tr8d3ZsttZi+5t51OqFxT22RXDiPW/KoBDkSByu329gpAr2muYckEzciKfrQ/GeWJICF02sBEt6lBw7rnTuybK31TeuIvty/0otzY9Uu9pyquDGOMjd5v9xL6JOOKqSiMSD3+GhNGsQ4NGeKDdGiYbZ+CcYIGDc8brGnY0C8jCU+JYENtWSvs6FDeQ+jdx3FY3YyUdZw2lTNGAgEJ0MXvoZkd17DZzwNp8Dv8md4DBRK1fRdsleKdeZNLEy/S6CA4ZoU0hcSYHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(83380400001)(2616005)(26005)(6512007)(53546011)(6506007)(31686004)(478600001)(6486002)(54906003)(4326008)(66476007)(66946007)(66556008)(44832011)(316002)(86362001)(8676002)(36756003)(41300700001)(8936002)(5660300002)(186003)(110136005)(2906002)(4744005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Y5M1FhWUFTZ3Zxak1JZ0tWZUVYeFRPSVlHTE1nNXVRS2hZM1RFVXBiUVZY?=
 =?utf-8?B?b29tV1hiMzcvdnh0SzQ4aTVkWmtMSUZVbVg2cTNMWWtVdDg0dXkzUmJIMHRk?=
 =?utf-8?B?SUpSemVPcjNvc2hkUzNKZ2tXa0NzV0kzY3JEY0ZpY0xWSUlVNllta0c2WjZu?=
 =?utf-8?B?NHlWWnBzZVJCUE14YjFJVjQ2cWxFR2FoRDFhK2xTbnhBeTI3L0dmbE5GYU91?=
 =?utf-8?B?endvb2oxMVVjSXB2SHZJOG5mUnBoclE2V0xNWEdDTFZoZmYrd05rS2RCNDhP?=
 =?utf-8?B?cGlnVmd0ejNVREtqbFhQY3ZNeVJGeTdVeUVaWmcxYTl4T084Z1JkMC8xdm5X?=
 =?utf-8?B?Q0ovOUw4N1gycnNlemRLOVlqSU84QkJiT0hybFlWNjM4VExRTzJjNnlTcFJU?=
 =?utf-8?B?RGJaVGVxT29QbFpZTWNVYVl6SkpzVlZveTlxUTZJMktFbnlIZGFod0hhMTRK?=
 =?utf-8?B?QlRJR3gxQXppS1dRSkxGaTdEU05Bclo0TC9lUGR2Q2xCcmthQWIrR0Q3TXJZ?=
 =?utf-8?B?N0NUVFhiNGRMZk1sSm1WSVZybS8wYUMvVm5EclZ5aDM5SVcwMnRmVDREaGV0?=
 =?utf-8?B?eE94VWtLSkVIZHB0ZWJDdVI2TmxHQUN3Zit5SVI1b3JwTWhta1lIU29FTSt4?=
 =?utf-8?B?ckxzUy9jS0pyTHgrVFp5R2ZWUXIvRnFCNHRncmMvZnVveDFPTDJVR0JzTUMy?=
 =?utf-8?B?aG84TGZzMWdBb3Y5V3lRQUs0dEVoQUcrV1crZmdxOVZYdE9XbEZkSnc3NUNK?=
 =?utf-8?B?ZkxMS2tRVWwyTzZFTmU2V3pDOE5pbVZMaU9MU2lPR2FhdHlMbTNwZFIraTUy?=
 =?utf-8?B?UDdEbU1rV2ZCOEl3b1EzSVo0OHZoeUkxU2FqektBZUgrR29nbEtudXNRb0VC?=
 =?utf-8?B?N2lUM2hyMmRiQ2l5VFllUUVmRGptaGRKWTQyVDNpQi9NcVdHS2w3aUhKMldy?=
 =?utf-8?B?RUFXR1F3c3FUbjlDYitJS28rdTVjMk5JRVQ2Uk1jNCt2NXVFbUthb1Q3aTR6?=
 =?utf-8?B?MUdNa29IYWI5Mmd4VjljcmQ2NThYWDRsNmkwMU12dWlWTlVJWDRwSXptWTA4?=
 =?utf-8?B?NnFYN1piYkxKWVB6dDN4RUE3V1M4aW9OL3RoeTFjK3Nya0REdVI0MDE0aHRW?=
 =?utf-8?B?a25QMU5yaXY1UmltZzZ3NGk0OUtOZS9wSDFrRDgyTUVtNkJibHlxME5wWE9E?=
 =?utf-8?B?SHl4TFlTTllpNUx4OEY3Y0xIRzBFdElUWU5aVUdMUU1obnV3WkFaK0EvbjZn?=
 =?utf-8?B?M0U2dEFJU09MWHJTUFVDYnhEQUprWE11bWtMcUVpbGdtTVhDMFc3UFFMaWtQ?=
 =?utf-8?B?M01VUG5XZHk2ZmMwQk9UUDlnQ3ZjOGdDbnF6ZzlNWWhLSU9mTDdBM2pYaU12?=
 =?utf-8?B?bTRFeDIveFp2UjZZQmc5eVhZcUk0QlJ0azRrM3NDcVNtb1dMUGo2LzE3Z2xl?=
 =?utf-8?B?L2xuTXVpbldoWjZkNUxFTThIVTQ0REFJRk5OQ2JiendzRGx6MmpMdU5wSXo5?=
 =?utf-8?B?Mzh1U3ZOcWkwZ0ZnMER2d3oxeUJPZ0NYRXNHVkcrc21DdUpncmc2TXBYUWFs?=
 =?utf-8?B?QzFGZDVyTDBCUDR5NFk4NWhkS00rMWYwZ0ZEL2pmdUo2bm82emM4L21LR25D?=
 =?utf-8?B?Z2tYTFVrbG9zZFMwUlV1a0RjYXZWYWozcVZDTWtqY3hTLzVGK3hwdTIyZ0Z1?=
 =?utf-8?B?TlRNbm1Nak5hQlQxQURzSktoMjFldklhV3lJSTIzWXB4WUFxRnJINmN4RHQ2?=
 =?utf-8?B?RTRJSzBrWlgwQ0NQVk9yVlFVcSsrajdXaGZMc2Yzb3VwaHRKQjBtSXo2QXJy?=
 =?utf-8?B?alhKOWl2YVFvdi9LZXRQVExDZzRFY1Q3RWhCdkZLSjdVQldkcm9aYk1GcFBE?=
 =?utf-8?B?dmUycStsTisrVS9RRHFUZkIrWmlPOGtGRVN4NU1XVEtCUGFYcGY0Tng5bmhp?=
 =?utf-8?B?YU90ME80MEVublp0TnRqaXEyK25wWFZTMHdEQzMwWmJCUzI4cm9HZVYrYkN5?=
 =?utf-8?B?REN0ajNobFBRMW9xcnFDdjJNRWN3VmhBeTlhQXd0QnpVSWhmNFdnRDN5WGhm?=
 =?utf-8?B?QlpjNnQveDV4Y21LM0JiV2JSd0V6VnU0aUtZZUkxZGFVQVl5N2R6MUdSTDNn?=
 =?utf-8?Q?UA6kzMYEnxwehD0gpE1lyP1o5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc1256-0a37-4f19-41ef-08db40d71b71
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:08:02.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq90u8fa5xiUqBwuUILbYgS6iCz1oSO6aDj70paJpCXdYn/1Z0t1FkfKSzRK7efPLUyE1eMRfsNtY6tHxJ5vhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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

On 4/18/23 15:34, Luck, Tony wrote:
>>> +		if (mce_usable_address(&m))
>>
>> This should be !mce_usable_address().
> 
>> Copying old patch here. Feel free to reuse any of the commit message if
>> it helps.
> 
> Might as well just take your version. The commit message seems fine.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 

Thanks!

> 
>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>> Date: Fri, 8 Jan 2021 04:00:35 +0000
> 
> 2021 - wow!
> 

Yeah, I've been distracted lately with other things. >_>

-Yazen

