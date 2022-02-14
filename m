Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F24B5929
	for <lists+linux-edac@lfdr.de>; Mon, 14 Feb 2022 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbiBNRzS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 12:55:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiBNRzR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 12:55:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4822AD2;
        Mon, 14 Feb 2022 09:55:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pal/1InI0+s8iZ5vHyebvmv/a71ATs/4TxH22EwyWFXQSHEYu23Ai7uG9+uCj+ryklZFzGsv6baF9ZZD1/YSTzsyc2yUQGIRtSL+V/Ukh/JCUKsf7l8tTg9tjla1HlHMaU81wx6ZIljpvWbYjsf46IW6OkTRw9jp5BSq4rGgLFRHEjNXGPJatxtE2xuUX9ohpLyE5U8S1o1WLiEjwWGmxU343+x3GFN/OKiTRU0osk2cEe1VxFY6RlkoXDgFt5/12SBSBJpt8vLYMdvsPY6W03iMsA4j+rZ7VLXXXbONj5K1xjzUnJ5dHSX9e4KEbPpZtgdSmq6COYN3Y6hrH0tpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0eu29lEMO/DqZL51JNjI2f+aa5viQ30i66dKUxYyKU=;
 b=ajZ1DjnDa7gZtAPGuaKXWwQXYY8s/7IgVOk7a01VA7bx/bJh9w++AlJhQgrihbO7gAA/BBCUwmvQj9B9VpoD6mAhOiDfaQ2HkMtQhnKbjgWU3xwXkyU7nkFhAe+RC+VZzxch9Qq1t1B6mSBWOYn+z+xd9oZMi46oZ7hF20HlA4SPAgBC5fnpNWYiemY9vTDi1BTslzXtzIH8mk8ctvgbR3Ug1HIw8laX2ArSO2rHMt1pJ1RJ98V3wL5v2dEqNRG4+4RJKd1kujS1TU+8EBjGF+vL4tdfERvuM7crWqVzL+qJ2urpcsdsGb5cAbM/BhD4zaCmChHM50v1MEfd1z20fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0eu29lEMO/DqZL51JNjI2f+aa5viQ30i66dKUxYyKU=;
 b=1DIItAVFEttpAYu+m9oDt8jnt75cctWN1tddV1GLwPqR4KOJu2go507cz85Vt7K7EdtpTI45by0rdF127LifUsnqDhq8h06Dr1a1k8X8XdsMUYOs+MZKqByTmGMbX+VRwas4HA1/fS/Z13kuMjVLBg4iQdsgcUMSU+KU4BdIUKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BN6PR1201MB0001.namprd12.prod.outlook.com (2603:10b6:404:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 17:55:07 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::487c:b25c:8d6:174a]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::487c:b25c:8d6:174a%8]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 17:55:07 +0000
Message-ID: <c8c33c66-8b82-1fcd-9268-94a01a7759cb@amd.com>
Date:   Mon, 14 Feb 2022 23:24:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v7 03/12] EDAC/mce_amd: Extract node id from MCA_IPID
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-4-nchatrad@amd.com> <YgRO7afWufCF/fxi@yaz-ubuntu>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YgRO7afWufCF/fxi@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::33) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972cfc34-079e-4b15-5826-08d9efe322e6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0001:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00019B90EBE2E81D7B8B2B95E8339@BN6PR1201MB0001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKu4XDaBTlBq/jt77Ph6LczxUW+h+bEMhiiirwN5uJcg4sGn6/WwnHZEnSowJ8RLKgKM6lFd/4wKlMKdqzqEIt1CihmJNuAIH3A9vnmU2N/N0zMGUXfdekOx3aUi9kkVZ1JQdkW6ggP8HDibkhYlhJEIc529PCKfzRIBme+QGiMAFHtQUBP/+3TUsDQLZgdvoKG9SNTzbzUX2rpSYzvJ7H8YqRw8bGH6WxxXXjDzK76mRpMrOtaCe9mnbm7OFoYePxyiqbdxZx2A8PUBoka94C/voRTNvAkbVJMZBZKyyU1raWWD2jSHV/c9rFzyw/zgU4hRQ6AqssPL3w1OLRPrpR8r+IufZ2uw2gF4Zd3vj5IhVNzgl0xG02Rq6GllUA4i8ZBEbv4mq0J/G6ERyCVuYUc6LlkSyaFE7czR2BxY3cYGg6+axa1csxF/89ShP+NrBhynfnIzH04tDi6itNQ6hlQdTGAT95E8lJ3QK+q9BsUkWoCmvJY1+tOp616ki6/sOk2B1teugn66jyPlxjenVMMusO34K/ciJp9GKjJxmDfZoqd6FnfhoGKEw2AAR4EzPlnm6iDyf4lPa0rtJiThT+Qrv0TI+Jp1qZ6SlJYEGrymsYlFWPU32ZziNgmaENLjIJGqDbXX1G1Xa3Sok2tRqKUjnl8Kks7XDsoPhlvjEJ7SBN7Ix3Vm/9nTfUGokPqsRmaMSpqYbZZQLWMvDI3CleG5MLbQ/47muzvW4UnS+V6u1wNdlR5G++DxQ6Ihf1O3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(4326008)(6862004)(8676002)(31686004)(66476007)(66556008)(8936002)(6506007)(508600001)(316002)(38100700002)(5660300002)(53546011)(6636002)(37006003)(6666004)(36756003)(31696002)(6486002)(26005)(6512007)(186003)(2616005)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUcwQ3RabjBCYk9EcVVoNUZzVU1yWUhJNmprcmVERnRMSUwra3ptMUo0QTFM?=
 =?utf-8?B?Qm9ER1hBaUt3cDFkc3J5VnE1TG5qeXhlYXNnbi90WkZEM01aWnliR1BoZ1Ru?=
 =?utf-8?B?d2JZU1F0VE04MVI4ZHlrbmNaSDJKS1pBdjYvYWNOY0pob0dNSWFtem50S0h5?=
 =?utf-8?B?YnRjRnNCb01MSmdqQnhvUWZKTExhL1YyRmFvWEtOOVc5eGZWMStoTDhEQnhC?=
 =?utf-8?B?WksyRkFPeUordGR4WnNwdXZQd0JZN3VuYmd1SWFCNE55cGFpZXprRzR4bU5U?=
 =?utf-8?B?ZFRyai9Cc3ZJTmxWanhNWjJmdUFId01ENEZjc0gvVHJpanBvOFZUeHU1VmtG?=
 =?utf-8?B?bTRtTjFpSVFONHJFSUtkaDg2TGplMHloK3BPY1ZyY3JZTC9WbUFUTG1ta1p0?=
 =?utf-8?B?Yi9kbFhLdkFWekR0OEpISEdEcVlVN0xiKzMrT0IwWHpteFFhL3A5TndBWHdl?=
 =?utf-8?B?ckd2bk1MR1NIc0s1c3plMnRVeDBpajlFM2dPYnU0dFVMb0VHVnl6ZVpVU3JI?=
 =?utf-8?B?V0haV2RKbTQyWUJBbWJyOVNpWE9JS1JNK2EzZml3Z2Z6V014bmJrVDF4bmdJ?=
 =?utf-8?B?cW45aUdPVmppemZNMW92NjU1SDYxYUZ6RDlQSXVyVDJ6Yk5Dc1dzU0gxMnI5?=
 =?utf-8?B?QzZjQVlDU1diblBNTDUzTW9jNjArM2s5NFlJd0E4NFBYYm5QM1d1YVJJOGhs?=
 =?utf-8?B?VURBZjdUYnlYVnRURXc2OXFQTFRDQVR2aldzRFN5VHppY2FzRGlWbVVvbkt5?=
 =?utf-8?B?VXVNNnR0dVQ0ZVlvMGpGZ0xQNmhZT0h2SmhJWmZHb2NlcVJrM0UrZlJvd0JF?=
 =?utf-8?B?M2V1Mms0VFVhOVRibHpUYjNPa2RCTmFtT2xiSFVjTzRYZlEvQmtJdlQ0WFg2?=
 =?utf-8?B?TDkxMGQwVkZVK3hDVGdQb1lSYk1acTRReG9OaTFpQjZQbm5OREpUbnFzdVIy?=
 =?utf-8?B?amhMNFJBbklSM2ViN1RYaUhreGVCbXpRSmFOSjh4QWpUc0N4amlIY2JnVG0x?=
 =?utf-8?B?RVREYWdkbGpMdkVEWHlndnRpNWtNdWtuRW1DVmxCdk9SN2svNXpGbmRkNFhI?=
 =?utf-8?B?RnBhdDB1OG0zUklFUkxSVW5tRDU4UkdLRlM4WCtiUVJkT3RzbWVZOXNPQXlC?=
 =?utf-8?B?UHVScFlVV2J0a0dPVUJ6ZHlzcHg0OFQ2T1JRelZoMU5FQ3ZNRWRheGsvTVJ3?=
 =?utf-8?B?cTU2V1N0SWRlQU5GV25ueUc2MWN4Ny9taGJ2dnNlVnJtV0owYUVOazEzSkZm?=
 =?utf-8?B?UWdFQjFKbVU2OXFPNkdQZEYrSnZmY3hkWGgwYUJOK1JqUTVFekVVWEYwdmx1?=
 =?utf-8?B?M3lrYjZ6WUdlM1RJSmVXNVZTWXE3VlZRNUVyT0I3bU9xQVd1KzIzSEpXWWlQ?=
 =?utf-8?B?eE90ZU9mMVMxOWJEQitMUW16NndJOVdDSDFBa09VYnhMUlh2Vmt2TWF5NUhE?=
 =?utf-8?B?R2h2OEtFeDJiWkc5MGNFRmdNMDhRQ2RDT3V0V1hRNUE3MlFIVldWRlcvMnhC?=
 =?utf-8?B?RWFkb2JXUHdreGdoem92MXlKNHZGa3lWRHFYVUtpV01PcVBtYzRQQkxlMGE0?=
 =?utf-8?B?RG9NRDZjajM5c2tQeWVSUU1MbkdhVzF5cU5zUUIvd0NmRE4zRGdYbk0vSlZR?=
 =?utf-8?B?UTVCWHVZbWJmQmJscGowY2I2YTk2Tkx3WWNYRHI2NlpwZDlkakZvYnZjQVRj?=
 =?utf-8?B?aFpWLzVVaVhqeEhjOVV5ZHdPa0pRRzQ0aDFWMWdDeEtNSk1yYThNekF6b3Zw?=
 =?utf-8?B?TjhwT1ExMHc0YzcvamxYSXBuMGVZVGh2MnU1d2lyeldsTkx3SXZlMm5wM2tF?=
 =?utf-8?B?TWtkQzBSdFYvdjdlQ1p1SlZuVWZ4cGw3R3BrU3RNQkIzZ0hraDFXOGYvS3JL?=
 =?utf-8?B?TUw2em1FMlM2ejlkRzZLZytyU0UxNHdpM1Rrb09wRkQxTklsckpZYlBGZURx?=
 =?utf-8?B?RnZiaWpLQzlOaFh4SVc3VzJmZUtJSHgxLzZiVHNTbTBUcU01WmdDcy9HQmxT?=
 =?utf-8?B?NENIOVRkZ3RObWFJTC9mV1d0VEo1UmZFalI0ekxDQXZZZXA5RlRRUEZ6MEdu?=
 =?utf-8?B?ZjNPMHoySE50Q2ZIeEFRTytRQ2twWlE2VXdBdnFVY1Fjc0V5T1htc1V2V2JB?=
 =?utf-8?B?Tm4yTk51NXBQblI4Um9JelBlamgzU2R1dkdtc0hxL3R6NlR0cWVMNTBvT0ZU?=
 =?utf-8?Q?9HW5Uno3Po0quz48+0eG9Oo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972cfc34-079e-4b15-5826-08d9efe322e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 17:55:07.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/VzSQNXJ0I00ighvYJB7M+MCbc5DRlpfvfShYHRDJiZHYYaikRN2497vnpnkbcNOBUMrifNMCf7SQZTPeTLTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Yazen

On 2/10/2022 5:01 AM, Yazen Ghannam wrote:
> On Thu, Feb 03, 2022 at 11:49:33AM -0600, Naveen Krishna Chatradhi wrote:
>> On SMCA banks of the GPU nodes, the node id information is
>> available in register MCA_IPID[47:44](InstanceIdHi).
>>
>> Convert the hardware node ID to a value used by Linux
>> where GPU nodes are sequentially after the CPU nodes.
>>
> Terminology should be consistent. I see "node id" and "node ID" here.
Will keep it consistent.
>   
> ...
>
>> +		} else if (bank_type == SMCA_UMC_V2) {
>> +			/*
>> +			 * SMCA_UMC_V2 exists on GPU nodes, extract the node id
>> +			 * from register MCA_IPID[47:44](InstanceIdHi).
>> +			 * The InstanceIdHi field represents the instance ID of the GPU.
>> +			 * Which needs to be mapped to a value used by Linux,
>> +			 * where GPU nodes are simply numerically after the CPU nodes.
>> +			 */
>> +			node_id = amd_get_gpu_node_system_id(m->ipid);
> As mentioned for the previous patch, why not define this function in EDAC?

Sure, with recent changes we can move this function to edac. Will wait 
for comments on other patches

in the series and submit next version with feedback addressed.

Regards,

Naveenk

>
> Thanks,
> Yazen
