Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFD44DA5D
	for <lists+linux-edac@lfdr.de>; Thu, 11 Nov 2021 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhKKQ3j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Nov 2021 11:29:39 -0500
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:35169
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232033AbhKKQ3i (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Nov 2021 11:29:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT9AK20JKqV3n34Dczx+EnZfPvvj16I6CYk8RydSeeCE6ZFGwBTUU5Mu2vfcY2L/2elPhUliyxjOGA+WlrZkie/YhEVFPvopSViZC75bRUHZxP2mo3ggJLsfZFUeQ5fA5i6qWO/qEZhiXgLYlHKmCh4oOxgdd3McDuJ67VczS2E5wAe8J/5ZhAmK+1+9WDIqB9OUykJ9JmW35PfknLKRufu7WJMq9ztkf+WhGhf1s7tDOfIqYD/k9jmxl7d6oAvrI2JndjF8HH/lyBW9nFJYHBud3tY1TtwSImZuDxCq2/6PqnUJzj6wjvtaVxBTp5IVBFNHc2hEQ6TSnL3jCeDZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF2tIEAd/hORzS5JrONzxt6v7yLk/jUxh6DgE5e20wQ=;
 b=lRTagnHGLN3LAOKWJ0R26pt3H6KijLvxiE+gSXpUCu0SwZIobpIoXx6PrCkQazdrHM9HgHxWkYLtq9soK922xHfWZMRI3tJDRJ/9DOvXkgK8TXZnzSP7R0LNkGiLk2RsjpYp4avYHAGhGVojmt0L8XXVdX7FThtPaFPUV3BQCFidwHsDA1LY3Bhuk0rSulghTvOxRj7L9Lj5Zsgxhzenpls2p8tOyLd+bG2q5OB3K5XBzfghgvU1Z2nFe16uhXQn1VcZmQZCd4MLBLMsio96rCacR5mlzFYTpzWXQ2pdBt6NGqkNmvXaqmBAMLRoNdf2Zv36VuV3fU7+XYrDOBPwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF2tIEAd/hORzS5JrONzxt6v7yLk/jUxh6DgE5e20wQ=;
 b=tmvDpy6naSIB9HHkTFFJawMVvbBc21e5wBQYSBKcgicQw4BGIcpUXTI7c9zufDDTbxWT0NkF3tACX8RMkRiXcJAeCSIaZ6+bykTC2lbI/oihcgxdh77gT/7y+lvXTk4tzAr7rIC/zGK3Z56fJ+2MUG1p+dQmsG4iDuQshPAoT9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 16:26:47 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%7]) with mapi id 15.20.4669.019; Thu, 11 Nov 2021
 16:26:47 +0000
Message-ID: <df95662b-963d-eae8-5013-5f2a68da2512@amd.com>
Date:   Thu, 11 Nov 2021 21:56:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 4/5] EDAC/amd64: Move struct fam_type into amd64_pvt
 structure
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-5-nchatrad@amd.com> <YY0PDMUjcbrfY9EB@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YY0PDMUjcbrfY9EB@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::14)
 To BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by BM1PR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Thu, 11 Nov 2021 16:26:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08faebc-7ebb-4faa-928d-08d9a5300ec7
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55552A25D20B92A9A0AF6A1DE8949@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiaYprour7JcQ6YsE2NzF25K7Dd90cRlInZmIqNXM7ru0H6ofOeK0vxako43nzTOno/r083JDpoUpRepVUPEPX2HSp1zHfNzGO2gczA6cCrN6tbIjMQUuteCz9ALkFyQ03hwHqQMI7pZyaNY/zjN4r4Xavw+L165ElzPVeYVBijs7u2KL0FbAr+t1egnG6x+nlIYZzcwJKYzA5HLMNqvJcYuwQQsB/vovLU3F4O4FtHwpmtQKDdcZOS49OOXMNDCCEbKZJncYyRR9vmCXjqxrq3s7JToaM5Hio6jAHs7P6eAfHP1x7zUsuZ6VflVhmfbb7LX15RdwklnmhRduFj3k9oZwzjWpXgJxyyPhCoUY248ScnuFiPzA81ZvcDOOtlZ6RvOo1Q9p8nGFa9o2Q+/5WrBgyoPOWf8/wdb+EVG2gHNdOX3p+YhM9eSOqVzNwpbnHWUHfevv5DNKq3bT38plWUvFwzOEMRgRDDR8Ll8NMED8RTxWOTP0V1AiJDHxTdcVD4SApDaUkOjy7l4h7GEtubbDFShVe4af1ZCVALPGQjL0TUVedV7G+kZttVk6JVCYH5oOMu/K8NXdCGMfmLiqOYCKaoCPdMeZftU99uE7fC+ssffwJRywHKK+myPbgEQq+a1uUc5W2MjPp6S8kaYo6jMAZ7AWhTvA9ltb+bK/oE5wsBDb+gA9vJj5/+lvbvke67wxegDh0Yhhr8kpguNr9g3MclFT8U9GxMLR5OFhiGCMEP3TdVP/VJKHQUA0axPRemm1jr+8e7ozY5bWRomTHkwxA5UudONx/0p7knpWV/nVBqdOYmT6Q+oZiYv7uDlknk1mYAJ2pT06BN4eA9Rlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(31686004)(186003)(2616005)(6486002)(6916009)(966005)(316002)(956004)(38100700002)(16576012)(6666004)(26005)(45080400002)(5660300002)(66556008)(66476007)(508600001)(31696002)(36756003)(4326008)(53546011)(66946007)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk50WkxhZzJob0cwUUV0T2V1UDJHR1NFdDJ3T0JhYndXVnBrNG1yNFBhR3pi?=
 =?utf-8?B?SUxndUVDZzBMWW5hQ1pOQnMwWWgxK2lMcXpmdFpDNHZXa0pLbTdaOUFQR09B?=
 =?utf-8?B?M2NGUkNmc2pWdXBKNmZlZUJSTkNwbEpZaXZVN1Z5dkt5MXd0Z21CTDFSRXpp?=
 =?utf-8?B?d05KNlZKQVdOWmdpQVZ1SUIyWjZJWXE4K0pwNEovbTVQVU8yQTF0MGFUYVV0?=
 =?utf-8?B?YW04bzNiMFA3blJESTFFNEhEaEFEaWo5UEMvN3M0NHJtaVpTMFJEUFFCUUEw?=
 =?utf-8?B?elhLMkxHZjN6RWdiNFVGTWJmdlFOajdrNjVnOXdxcUV2YWVJUGFUdTlLZG1h?=
 =?utf-8?B?MFpTRitkR2F5a2VpWm1tNnZXdmtOVzNFZm9Vakx0eWNvSW1uWUIxRVgxcGo5?=
 =?utf-8?B?TG40Y1NCMXdXQzJjcnVLUVdRQmV0VXJPT0VGZFlJQytYd2xPTG5nZEJkZjB6?=
 =?utf-8?B?ZGhUSVJBYks2UmdwSHJaMTV2VFFZRCs0dktyTitwOFlWelhpYmRyZEJLb2J3?=
 =?utf-8?B?azNUb2IxRzNuUG4wK0JQamtJVTlRU0o1UWhKWi8rTDVjZGNzb1VROXJDQ3Q2?=
 =?utf-8?B?OW1zam9vYU9SN3poK0RlamRGdHNvYVpCSEhneUtWNnN4MVp5YStlbGhRR1BX?=
 =?utf-8?B?TEVvYXk3bXdRaVN5RzBJSVY2OEN5dFQ5S0FwaGdBTVl0citXQm5RSDlXNzhy?=
 =?utf-8?B?Z1AwK1BkSzZRbFZubFFCQVRyc2RPNGc4OThCUytGNnl5c1ZuOU9QRGxNYVRw?=
 =?utf-8?B?K0c3WVJUUFVlWHRDZ053L3lra1RBTm5VOG5qSW82alFUd05qT3NGZWlqZWVC?=
 =?utf-8?B?b0Ivb1ppZGZhWG1lTzc1M2w5VXNNTk1VVy9Ka1lCb2grNXc4K1JvN24wYWdF?=
 =?utf-8?B?dXRVWjduYTJ3dVpLZE93TGxRTCtqRTJEUDI1T1dERlZBN1VDRURTTkp5RzlR?=
 =?utf-8?B?WmZkdURacWFZQmNkSnBDYW9kZUg1QzViZXhsMWlNb2lldUVkOTlEa0VWNGF4?=
 =?utf-8?B?enJIb3VEZzJ1Ym9SeHZPV1doQk9CY0psOWJyVWNPUFBEMXNUUFgrMUNZU1ZJ?=
 =?utf-8?B?OWRlVVJEZHdseEcreHlSaTNoNllMOVI4SXpYVkhIZjVrbnFrRDNZQUNOdy9C?=
 =?utf-8?B?U3BrMFpTQlI0REgweDhoZUs4SVdUZnRpTVN6OFNTSHk0ejZMeVVBaVE3NVJX?=
 =?utf-8?B?V3VEKzNXcHBrSzdIcmVpUWJvTGFYblR0Z20rbXB6bkVLb0lDWWVIRlFaUUpn?=
 =?utf-8?B?SGx4MkxOaGQ1YTFVQXM1d2FDK3lBMmN6dEw1ZmpDQTA0WE9HanhBYmhGczJX?=
 =?utf-8?B?M3JKNzVucmJ2Y01RYllIWEhpcHdTVnBIeEwxK2pqcHlTK3l3NVE5dzRTakl4?=
 =?utf-8?B?cWRDWnMzVU4rcHU5MUk2OUR0UXdXZUJjbnp0SUhTbGpSbytjRVlYcDJLdDJy?=
 =?utf-8?B?NlN4VEg3aVpVb2ZadHRwWDFyU2Y3dzluMnhaQzNqeVJMSGpLZlJoQjRNaWFW?=
 =?utf-8?B?ZUVZekc3V1pGZlZMWDBYOStzYTBMS24xUmNkb0JGb29aRHVGNWVKU1pCaG5h?=
 =?utf-8?B?eHVTYWZzQ3E1YSswVDhZbzZlclBlUnhlem13c1BhbUk0U2JkZXc3QURqUDdq?=
 =?utf-8?B?aWNIdjk2NUx3MWI0aEhtOEVRQ1dQbnY5dThwOWVGMTNXTzhTNWJGMjA5MDNT?=
 =?utf-8?B?d08vd1I3bVNId2s5TUpwTFZCdHdDSG1EMmR5SnludjIxa0s4TVF4WmNCUWJx?=
 =?utf-8?B?dGNDN0l2em9BRWtuL1FKb01yN0loUldwTDVSNXJpTDVWcFZKRkpIK0pEUU9P?=
 =?utf-8?B?cWMyR2YwTTVtajBoMk1ZdTZDcUY1Nm9sLytFWVJPUFc3Zmw2aThBR3JqNjR0?=
 =?utf-8?B?ZUx6WlBHSUZRZ0ZsVm40UUl2RXM5bWEvY0c2LzNWMXB0QmFFWUlDaldxNnNt?=
 =?utf-8?B?TUJUSzVKcEI3SlJjSzdIOEtVTWNyV0dLdXBzS09ZL0xZa2owUTliOU9TT0tU?=
 =?utf-8?B?cE5VWVYvTyt4dFJnWUVDMHhvY2hYY25UTlVzK0VjRURnOTVkWTc4VEF4U2NG?=
 =?utf-8?B?ODM0OVcrUTliTkJOc0NqaHdmangxNlhRTG1Tc2VtVm1FUFEyVjA3dGZURnBF?=
 =?utf-8?B?Um9CdkVNZUpNbzZIVWhTSHBDRjA0Wng2aG5OSHV6amh4WW9NTEE1dlREd1cv?=
 =?utf-8?Q?51GgMsIm3nR3gCcn7pjt+O0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08faebc-7ebb-4faa-928d-08d9a5300ec7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 16:26:47.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3MD7wiEAhzQtfzAcebmQQW2mc1P/iI3UYyp4fTc/3I91oSGy+5gNusFo2UA6X+rX9iWUhaHz4mM+LCKy4L7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11/11/2021 6:09 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Oct 28, 2021 at 06:31:05PM +0530, Naveen Krishna Chatradhi wrote:
>> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
>> index 881ff6322bc9..82d9f64aa150 100644
>> --- a/drivers/edac/amd64_edac.h
>> +++ b/drivers/edac/amd64_edac.h
>> @@ -389,6 +389,8 @@ struct amd64_pvt {
>>        enum mem_type dram_type;
>>
>>        struct amd64_umc *umc;  /* UMC registers */
>> +
>> +     struct amd64_family_type *fam_type;
> With my suggestion to the previous patch to assign ops and per-family
> members dynamically, you can just as well get rid of struct
> amd64_family_type and put its members directly in the pvt structure.
Sure, will do. Thanks.
>
> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7C9b4ca167dcf14dd0939708d9a5105785%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637722311903173760%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=lTO5cXSqnkx8Mb6yqP4WnNO1zBTOoqKTt6nWfUFHylI%3D&amp;reserved=0
