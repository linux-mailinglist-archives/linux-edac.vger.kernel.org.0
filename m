Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D4355E2CC
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jun 2022 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiF0U5r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jun 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbiF0U5q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jun 2022 16:57:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E215FFC;
        Mon, 27 Jun 2022 13:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHCuxH7HdM0ILM0iujVG5k6iLOYtNqFCTj+c0qS7owu104Ni7PpC1yJgt/6joTAeFoW4czrEGGsgTeMAS7ZC3EqjMXk5YVO8w841ovFbJX/eC/sPIT0dOajA9hp0p2y7rdPGRuLjCPlMzk8V/yXQH6y3t2NJ25R2V4DMJPnAMVcjpmFRD7Watute4GBMioDIo8cLRqXSv5THh2QqPUggeNJzq1JJWUMsNA0JeM2BG2UPteaE5MYzJGLgjADnY5kS580lJ5lZrsEsQHhCdwS+kzALhb5iHDttknKearC4ffiPN/F3eKyXGDe9TNi/lm+e+/RHu2JVWo5Wmf6vJD9vRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U5mj0HXL0mbmVH436zUNc/RBX8NPbuLeMqbA0nzx40=;
 b=k0qJvBqdbkeZKFsAY/c8Q2naXSLDHb2ZbNoPnh7JVhPHZbShhHXyyNz3/7J4szYkoDJBFfl889BA8tpneYMOKzokTISbHS8YwoCzJxDKwzVAZYuYXaBRPhtIP1HBknzOsuv3xFYZF+k9CNx/xfHEHSF2NPQ41k0NRBcXgjySrH0wlBmWXoGEd6CCw4hCr9Shs3b9etOqx9f0VMDYkLpKZB18yW2ujfgU6tWDWGJmX3yScM2DE8alj4iVYgpNhnr33B8UtS8JHWVsidy8WK8a9rbvxdYrywtIz/tiOTPM7H0c4+elZsdFXpD7ha03fo+aF6c1XSekx0Cf+Ws4LMwCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U5mj0HXL0mbmVH436zUNc/RBX8NPbuLeMqbA0nzx40=;
 b=zSmIgZ/dAkpvOl1IY2xInfHohe0Rj23boCKqu8LyITZUaMYcIh7fkIOA86iEwLohVL28YXP/JsRuJaoCVVvwRhsG6m5ajcpaHej3D29JWXtYbBF7OSqWavvg2vXMPILPqH2XkN2GJWWwZGFcbKAefIphPJSBqCh7/m9EVjrR0Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BN6PR1201MB0084.namprd12.prod.outlook.com (2603:10b6:405:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 20:57:43 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9dbe:b7ea:e0a9:6c08]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9dbe:b7ea:e0a9:6c08%3]) with mapi id 15.20.5353.021; Mon, 27 Jun 2022
 20:57:43 +0000
Message-ID: <02bba339-bf85-f178-c1b6-13d553c4a48c@amd.com>
Date:   Mon, 27 Jun 2022 13:57:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5] x86/mce: Check for writes ignored in MCA_STATUS
 register
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220610192515.98540-1-Smita.KoralahalliChannabasappa@amd.com>
 <YrNRYJx0CNDNj3oX@zn.tnic> <d3f554b8-4fc5-efe8-1ca2-aa95c7e76eb8@amd.com>
 <YrcJKOUSJsmodo70@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <YrcJKOUSJsmodo70@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46b2eb1-3953-4606-9f82-08da587fadf5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0084:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sO4LEcnQ4E4lDyZISBLTIfgIEJrS9sjVZLiIW2FnDDJybT+vZpoML8CLofvip3EKx5KJ89FvdUYXuVwsJW9TW/y+SgV99AfN+4qlGdUQ6YaUQl6Alkj9jg1ENJFOEV0G7zdmgSB8WwYg8ZgRFeHJFbZJnWWjZCJc+I1bcDPZTy1mW8YlfUnkSeUKpmIkZBTm4EkBeWPNCdjNkHPji9Cry0n/RY0NZIVwwHp9efCAMl857iEOyQKSv9vCiSoKu9WEpTK+VkxcjHFPLD1hK3ijgzIUtjkRCs9DkPGFkDt4OEvLCfVjYBJTl/w4dC4l7v64xWeP67SUXoXVOlyAQhbeA91ESnpGfEuCMlTInPG+RfRIAECo0s3CIip9PH0Vn92f+/y9AESF/5NpklPboUwae140JENityWFYqoKYyY2Zio4tfXULptyveYORCrTIv2efPxhwPaoDgSATzRdHBjopU0G26mlScx7mKpc9At0EaU5X1yrMaUJv0+Q8F4lJjfcBqikXQt5/I6MRzH4G2yVzrqLeAkhVoFumkDF3G1uAmM6UjGe/kC5Ik7FBrJBb6g6zlYGDAPf0CqlmB/Qtqa9AFpvNkfVFgeLaf7aGEf2+oNtw4FCYWGMSrxz9irn5rgJhOl5fw4zZetLYkbc02XHQbrRwLFYf+KpTBkw2UxPjyTr+XUstOVLumNhbKgIa0gerlWwUqCyUalZA7UDf+2ETpzc6Q8ul0hB5D3UKhMxhfoeANPchHzvrBBw+qEJQ4haKG6FEaF35JyymmHe7g4o2Yi4LtROEXEs+I3aCM/UhCt/UOTIwmE3PDAZRjb6IpYmem7gU8cRoG6uesPjZAvsVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(8676002)(4326008)(66946007)(66476007)(31686004)(186003)(5660300002)(53546011)(66556008)(31696002)(8936002)(38100700002)(316002)(6916009)(26005)(6666004)(36756003)(41300700001)(2616005)(6512007)(4744005)(6486002)(6506007)(54906003)(2906002)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW1LZlJBMG5sckRLemMxVFpCNGwzd0REUlM4VzRKVHJxRVFqSDJUR2dBQ0JT?=
 =?utf-8?B?TXAvbVNkTU1IZXNLM0diaGNzK0MyaG00N005bTJUb2pMQW1QY0cvUXVZUElx?=
 =?utf-8?B?cDIyUGJMZHBPY3dNS1V6MVZJZTlVeTZsT2NyR0YyK2VtUkJtOTZyOVFxZlVW?=
 =?utf-8?B?aXdLd2hZNmswUzFDWm1XYTlXbEE5blV5UHJGNTFRLytnVHFmNlhkMG50MjJr?=
 =?utf-8?B?aXp3Z2lFakgzak0ySEV1T1pTZXpuWTdWL3h6Z0xmYk15bzVKZ1NOYjU1Q2xk?=
 =?utf-8?B?VUg4QlplcG4zVStEeFY1TEJtaGxWZ1lCK3JpYnRrZGZvdWFENU1MN1VMbUVD?=
 =?utf-8?B?S2RaQldKeXo2bkpaTVhtOTRDaDFGUTFIcFZYblJxeUF0VS9ucE9sUllUSWZp?=
 =?utf-8?B?UEZiMnM5emRtd1Z5OEVlWkRlZXFyWmpna0NoOGZPT1pIWXFDc1dsdEV4bjZ5?=
 =?utf-8?B?L1BodWdCU254bTZnZFMvbjk1N0ZGaitwL1JMR3RZbWxrODJkeHFDcjBJZktx?=
 =?utf-8?B?dW8yNXRkWXU4U0l4T1AvTDE2VzRiNlQ1b0JYRmsrZXlRcVJ1VVptWG0zeXJE?=
 =?utf-8?B?TUJkZjVXNElCUGJsSWRkcVhMS01jdWVOTjBIWUx3R1BKVmdLTitJcHRsRHBa?=
 =?utf-8?B?c2E0cXE4SFNKSC9kUEdzMExyMHU3VnpRT2ZueWMvUVNCdldsQ2lPRUZPa25x?=
 =?utf-8?B?OHdHMVVCY3RIenVJWkpvRFczNTNTZ3hFRDBkazM1S0QzZmVaNjBURDFkeWhl?=
 =?utf-8?B?akZoRjEwVEwxdGtmNHh6c0hyOHN4YlhnNmVJbVYwMVByVkNERlpvL1hIb2d0?=
 =?utf-8?B?WGMxN3owSVNzeWpRZnduSzc0d0ZNUmo2QmU1dE80RnRFbDRVcm03U1dySWRw?=
 =?utf-8?B?aWlSbFVqTksrVWJBeVFRQkY5d3FNVFRCYk5sWHFITFlzR0xMMys5elZULy82?=
 =?utf-8?B?M2krTFFHdmp0ZzZRZ1crYW03M0NBUUVCTVFkcTc2eHJ2Mm45T2FHd3JTak1y?=
 =?utf-8?B?SSt0MUtPSDlVYU5kdzVaa0dob1hOUXo1aXJQTmZETERtdSt3ZkYzOUZGR3lr?=
 =?utf-8?B?b2RSUVdybmRnUHdmS3pHZ1VEYnEzWmJkcmlRMXZMR3FYSmVLcjd5N1hkRWZV?=
 =?utf-8?B?YnRYMm1KNU5BemFMYVY1SjdpanFVRFlVQmIrZi9YTE9ESzg0M3c2dFBXTGVs?=
 =?utf-8?B?aloxMVpjSTA5UkYwZDBNRkczb3ZVL1NKV1RrN1ZvSW5uajk3ZlZxL1NPQjh6?=
 =?utf-8?B?cUptazNuZXI2eWpySmZoVFoxcW9LdjVud2hxMWxLZFcvT1luQnd4Q0Z0NCt0?=
 =?utf-8?B?M0FFcmlOUTRZZ2xyTkU0U2RrWWpYbWUyWE9GKzg1eFJvTlUxR3NKRThBYnBl?=
 =?utf-8?B?TjhrQTErN2k0OHFYdWlMTG93T2daWHMxc3hGTE5JQXQ5cDVwN2dhRVMrYTFh?=
 =?utf-8?B?Tnc3aE9HTDFMWUVSWUpoSGpXODJ0OW81YlNyd1lrS25GK1hPYUFOaHlaTTRL?=
 =?utf-8?B?cnFYRGtMakR6dVF6ZFpHakIwRDRLZGF4UzIwRE83bnBGaGhndGdWUDJ0YWhn?=
 =?utf-8?B?aTJYTzhlckVaR1dWZGIxemppSWR6UStKMTNCMmhJQ3gwdUlSTUhIOWk3bkc4?=
 =?utf-8?B?R3NrWGNGTk02bGFVV0ZVS201VmM1d3lEbG1UR0NneXlNR2dIQ0h4cUFTQzJn?=
 =?utf-8?B?Vmdud1JudFUwQkVVclJJVWk2ZExpMkFZMmpuMnlUMzNHTEcydmhaRHdsQ1Va?=
 =?utf-8?B?RGNxNFIveGRuL0xQdm1kZjMrZm5ucktJWDhvWDJiMGdKMTRXMlBlWVFsS0Rx?=
 =?utf-8?B?aUZRdi9JREdxazlVMUlNR3gwWXA4cjBxejVmWHhkWmJCdUQ0RXEwbXZnbjN3?=
 =?utf-8?B?WHMzbzlpN3RkRHFZTWRLakNacCtZYWV3cGZkc1hEQXhkdDBUUjVza2wxVkVE?=
 =?utf-8?B?SzZKdVhPaTgxcDZSVU9GYkFmKzFweG5LcEF2UE9ZV3VRZG1HZUQ3SFVWZEE2?=
 =?utf-8?B?dE1iMDVoeWl6UFhZSUsyeXNTVGx5WVdtblNaLzh2ZXRUbmtkNklUSnU3VHdV?=
 =?utf-8?B?TkcxcmJ6ZUtUK1BuKzVhWWRERUluMEtXdGtxRnBoWTBUV1pOKzk4UFdWT0tn?=
 =?utf-8?Q?It87s8NlTUXDXlrbUOKZ7TA0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46b2eb1-3953-4606-9f82-08da587fadf5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 20:57:43.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjPhNY4U44+NUmYHWvo0XSERpuBgOcRdotfnNF3N8pP/hMOjarEKONvGO2NBJJCDtKyT5CN0ypEGkz8NQwDx/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/25/2022 6:10 AM, Borislav Petkov wrote:
> On Fri, Jun 24, 2022 at 03:34:42PM -0700, Smita Koralahalli wrote:
>> The wrmsrl_safe() doesn't throw an error here.
>> I think we need to read back the written value and check for it whatsoever.
>> What do you think?
> Ah, that's the write-ignored thing. Not the #GP-generating thing when
> McStatusWrEn=0.
>
> Sorry, I got confused.
>
> Can you pls change that part back to reading the previously written
> value and send me a tested version?
>
> Thx.
Thanks, I have sent them.
>

