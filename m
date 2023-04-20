Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722226E9B17
	for <lists+linux-edac@lfdr.de>; Thu, 20 Apr 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjDTRuG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Apr 2023 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTRuE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 20 Apr 2023 13:50:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF41171D;
        Thu, 20 Apr 2023 10:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WticsIZndKSFz4iIHIL6cJeR+jcwFWuGL96MkiYdlQg9+epUSuPOlt41e5wYjlcaTmbHkYnbKGea+UbQTeFUrINe9q2icjX/zh/UCqYDEzeEnlxeS2QCT4FCnyUQBdK3dyy3jQdyQBnuIcS4J/SQGfFvcyhF5lzzFKBQJTMkpYvH02yhxhvIWFGIr8+zM6l4r6lDshQZhIwuRFOIZn2fTbX4EF4UA6OcA7Y98wZkmqfmVpgKeoV2orwwqco+w6dzl7EwqNWxtlFle12EKlANB8Be/pQG2hHL0hlv85OAgRkscNprIKoVnyP6gcSPnQd/XLSLVUL/ZBfjvS8lPbqZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gccZ3Oi33fdy3/ffchXzAIrP/jVHbdt8z7Pue8IAj7E=;
 b=Anr8S+VtlRPrpuICuXRvS95hR5t+AxQHp01JIJrBswj3DNlgYT1Y0JnqYFFd8p20cb6nKgvgfTIxTpwiPugoL9iaYr6ZnyVgr1l7tpTdSgeQssYQDSRttADIhSoibbUtifcZfxyw0357AvmCKks+QKRv/mftSo83CirSt6LhQe8xzV30ViBuXaI9bdKO2y3GSjt58OTfKOl7FHBhN/JDcEA1P3L5JBn0/TSluBirrABQNIDA3NjB4z1CA+rFO781mzUCxAwBOd3MDg/e+O32gmYECqdSfEHQ3cbEfVVyLa2nNq5i2Fdw6D6mlBCKjNkzlQ0IuBvcaKQlLvbep637BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gccZ3Oi33fdy3/ffchXzAIrP/jVHbdt8z7Pue8IAj7E=;
 b=o3h+kQijy71L7LJf69LQyQuYx5qBvOZ55+MpOvWJhfi9VTfI9E8Wj0WX0USUvZvuXzbwbpBd0wcjplLSB5ur0ilhjjK1+/3lqlYut5jaclsdU1CJZ9swTkzGFeBHtYSU47tGDPfmGatRAKmQTYWVV7qp1aRs7BrjLVmgfCwgWJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 17:50:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 17:50:00 +0000
Message-ID: <2d6bfe82-25e2-c475-c547-e288f3b0912d@amd.com>
Date:   Thu, 20 Apr 2023 13:49:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_stummala@quicinc.com
Subject: Re: RE: [PATCH 0/2] edac: Add support to handle Deferred Error
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kamati Srinivas <quic_kamasrin@quicinc.com>
References: <20230303125408.26971-1-quic_kamasrin@quicinc.com>
 <20230304033021.35896-1-qiuxu.zhuo@intel.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230304033021.35896-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:408:c0::37) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA0PR12MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 2343851d-4740-4f0c-0bc2-08db41c7a9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWaSlgud1rONDuraSlQAu3VgHBjLp5o8bmMyraTohkmSp/Z5V+Xki5hl0GFIxSLWAYxuLiDfw3sRsa4AumpMnmv3f3OJX1jBKjyxHJb1uGbHvuL7DsttcqfPhAA7oqTmwxKpvvyB+UQe07/T1yeu4v4R4XvTMKI0qPhBsVURlhe8Q+mUREGFHv/wbFafPLaHiwdzfvF61nFtE+scr5/69aTE0XQq+Mh4p7bUdt9n0me21RdmOApyRzrNmMYpAcX7sOxZAfIguSWzoNkbGGdedz8g22XnG1Nb4t0ATzKH9NAdDszqQaso/xp11PkeXVQo/OXMKFXxo+KSp6lVIx7OFEg0xGVvMAbwDhKv5N36fqpHgs6I4DjCGLrYvhuVrtxQEnn9/inGIqD3Zj7OsiYW7zQfS8G+AaL0ObGM1jUynSzgMfe/DYM60leDe09oZHpzK6RTisc8lr6DFzL/fIIANxTcLqly4KezN6vThVu2LBesaIvEebOW0wHCIvriveKpdI1dhfiVxAMrxHlW2ukUvNHGL/m2adqmQYDKhB8z0mohobtWs4kF1zXj5HHDGqOBYbK0gVYIgpPSFzL0nL9p86U7OHXZVRzXL6P99FS5agZGvVTLsKO0nePd5XT+xfg0iSOQsF3WnPG0GTkLzQs3eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(31686004)(4326008)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(186003)(26005)(6506007)(53546011)(6512007)(38100700002)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(36756003)(86362001)(31696002)(4744005)(7416002)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVNV2RqQ2hlTmJ2Q0tTbkh1MWYwTlFIdi9jYW9FVFFsQ01pWnBmZkR6VWw1?=
 =?utf-8?B?MzZRWFk1MUZtTEk0K3JEZGJpV2RRSDhnT0xqUUtrZDI3L0lnY1ZjejI2QUhr?=
 =?utf-8?B?dTZUYnFFS29XVG8rdFlVR0g2L251L3k2Qmo0cVBQaDFEejN3azhVVU4xaFN3?=
 =?utf-8?B?MWhIb1ZpOHNoa3FHcGNuQ2ZsQUQ2a3E1SldHd2lSaUxjYUNHengweGhMSGFZ?=
 =?utf-8?B?K2ltRk5OZktLd05wTXMzYmFGQnB4SUJubXRuaCtEUzU2cEpISktwdDBadnlL?=
 =?utf-8?B?YTdVRVZ3eVROQThjeDN5d2p6NEFFYy9kelBCRU91ekR6SHlOd2JPQ1FMRkNo?=
 =?utf-8?B?ZjVHd3FZUjhWT28zZGluVFUxYzJhMUl4QzYwNjc0T2tXdm5qQlJnQ3M1UXBW?=
 =?utf-8?B?dVlPem0rT2ZZNkhGVHpYV3M0bm1teExDdVhQRVUwYkNqYlJhc1hoNkh4cmE1?=
 =?utf-8?B?dU1ZQTQyb295eG1kWEFybkVadU5vNDBMVGphVy9ndnQydlFVY3lGcURTa0ds?=
 =?utf-8?B?d3VINU1CanppbkxZM29LbkJBRlNmajV3UG5GZkRqeENLc284SExWU3hoQUpN?=
 =?utf-8?B?L2pOb1VGeXRZMDJUYUFpWG1tZ2w3K3FRTU12RTNuZlJZT1NFWVd3aFhROEM1?=
 =?utf-8?B?aHVhUjFnWkc4OG14M1M2UFZndDZXcU1jdjNrazVaSFZMaFRKUHR6S1lKbjQ5?=
 =?utf-8?B?YXhvYUVENit6Nkd6V1JvcG9BMXlFOUlPVEJZckVzejg1U2gzWEh1ak5pQUF5?=
 =?utf-8?B?VVhDU1VJUU5JMDM2WU5wYjAwcHljTGFjc0JFZGFLL2dsMzR5QXFaUU1oOXNP?=
 =?utf-8?B?TE82anVZajBKVzFNTVdPbWlaSHRFWExUS3RsQVNGMTN2NXh6YjlkMTNmMnpz?=
 =?utf-8?B?aGpHdG9TTXVBY1VXb0EwQ040UzE4VXVDMS9Ed1A3M2t5dGVCT2JRNGplMXM1?=
 =?utf-8?B?UHNwcm8wZ2lXQitiM3VpUmJwN1lianlHNVR5aFRHUUhiK09tN3hWUTVTNWhs?=
 =?utf-8?B?bFhac1U1TWFBd0ttUWhmcDVZM1NXZlRHb2JFRTkwd1ViZkVjeWRENnRCb080?=
 =?utf-8?B?dUI4OVZMOEFZT3VrMmJ4S3FoczJXcktTMWlzRGw5NHJWVXFYM2JYVENjNi9L?=
 =?utf-8?B?OHY1S0RPOGdKWEdhNnk2Y1ZPZm95Mmo1dnk0a1dWa0hod2h1Y3IzbGpwRG1O?=
 =?utf-8?B?YXZxdGk2cjJLMnZPcnVQaUVzZHJHTk14Rmtzc3p3V3FvNVlqMkg0QWhFMHNm?=
 =?utf-8?B?R3JOc0ptSlF1dm5aMjUxZTVaS1QreVpJMGZTTzJ1R1RXb1RqZ0JKdTh0Uy9n?=
 =?utf-8?B?aTJrU0dRSXZIY09qY0JwRmE3YlBvblFXd2sxZkV3bGlJNXl5RS84Q3dzcnZi?=
 =?utf-8?B?ZitKWks0Y1lzQm5NUVBxQ2IxSUlrNWxMS1QzL05seFc3L2dKOHhZTlhCckh4?=
 =?utf-8?B?ZDI5SWloYjF3ZFBpVHBpNldJbkhnSGZBTFg1cWNHeUgyTlhFTzdBRWhONjE3?=
 =?utf-8?B?MHF5RVVaQzZpOUJVSjJaMXh1SWVXaHdqZHcwblU0ZzBBQ0NhVGlOdjJobkZ2?=
 =?utf-8?B?a2F2RmZMYWdKUHVkclEvRklqMHV2M3VqMWpyaWxPQmd0enltSjkzcDRSKzNk?=
 =?utf-8?B?eXZnWU10MFZIcDk3V1Qrald0ZXU5QVFyd09PY0JEVlJRZmExdDBhNzBwRWNF?=
 =?utf-8?B?Rm9Md0hmbWlRczdNdW5wYWp4bm1xYXRCWHZHMGZXSjdnQjU0VC9HUlk4VVVw?=
 =?utf-8?B?S0tFV1hxMnJkMThrVVZjbUNuZGFLcFNkS3pnajFqLzFzN2kzamsxNTBMSE9K?=
 =?utf-8?B?UjFmTUhMNFkrRUhDK0hacFA0R2MrOXJDWkx0c2pMZWZRQVZzVWRidVBLYWhu?=
 =?utf-8?B?b25HODJmMUZ0cll3S1FmOG1rVG5RMXRCam40U3d1TTVFcnQzMTU3YmpNT09n?=
 =?utf-8?B?R1hMY2NDamJvUkRLRDhPMENLQ09uYS9zS0FjZ1UrWXZtUGZlL00wMGlGUHdx?=
 =?utf-8?B?b2dMekhFSmd1c0t6TkZ1dERSN3lsQi9IY09sRDNXc3Yzb1l5aElmYU1ZRmZJ?=
 =?utf-8?B?UUZwdHJkVU16NUVWMjZCWGsycCtEMjNuSFlkdmNXOWVpd3FVWnpLYmEvM2lH?=
 =?utf-8?Q?BXwOQhR0kjncPKco9HpyfgUFQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2343851d-4740-4f0c-0bc2-08db41c7a9b2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 17:50:00.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW+98G3GOT8PIhlVFbvSLKps3jDnFYUSliR3b843QeKblnf33JjEQaErdj/qpQrDKHBTcG0PblwfdZu/OKHuzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/3/23 22:30, Qiuxu Zhuo wrote:
>> From: Kamati Srinivas <quic_kamasrin@quicinc.com>
>> ...
>>
>> This patchset adds support to handle Deferred error, also
> 
>   It would be better if there is a use case showing some EDAC
>   driver(s) needs this newly added "Deferred Error" code
>   in the EDAC core.
>

I agree. On AMD systems, "deferred" errors are uncorrectable errors that
do not require immediate action. This may be similar to "action
optional" errors. They are still uncorrectable errors and can be counted
as such.

Thanks,
Yazen
