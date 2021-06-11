Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27183A3A4F
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 05:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhFKDiq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Jun 2021 23:38:46 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:23233
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230479AbhFKDiq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Jun 2021 23:38:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+pZRWkvWOooxGPobJe4I3BvjeIZbGjnJuUBdT6y+xQwmbEg2jePEv9xru1D7KUUnKLCsiIgqWkww1bvbD0Li+ZDPUIgW7XWWd6h+cMPwnwlVw+E9HMskYn5wRKDxDCTQB0iXXj3mbHNkIA3lg/njXBNik+ckardyGXf3K3txuf4ukFkHbOzWx4aLvABrIbNBMeMoZrY3HqqSVYvtT1bmcQjqBP4qbuM/aU09p0a5PmuPRmZbLG/HL+zqOaN3tcvpVsYZPdzLktZ5y8YKhRdlpGDrjRoQj4I5DHCYV3NQMcpTa6VSI34QxIL73UwBSzk3FH51A3zZoKzkvjUfoCt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpdIFMrgUhD+ElNVCpvG+hypNRbffHz60bJ98m5kWqU=;
 b=Y/ajmX6/pM52Wqufm8KFAbWQR9m9OJn/IirjyApGBymxl3zciitLpxJOtVWEigUaAmy2EhuTSR8CnUCnSCYu8YgYG6Z/Z67EBq0pWfAALaSbCjCYfz1gCgTp85S6x/M3eZrdBJluEJnQXXc5Obs4Bs7bgBa4t3UhDJ40wpBzETzRIaQ4Tf2r+/t9bmVGf0w0SDLFBhYp5CHakrKgx5uktVSdGnGqS5aIKoUWig6RvdoX/F45KzV/B8PIQX2MnKSYKI+ODT4JTnN9V5PVKjf6ePTR3oUy6QJ/AouFLfUh8BycGOMSpFe+WmtygfSF+r6VZ5HctW75lOvtFeKVc9zYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpdIFMrgUhD+ElNVCpvG+hypNRbffHz60bJ98m5kWqU=;
 b=X4S4c342/WYHyfyxIOtkPKrZwV+ermqkdVODnSg/OcQuJsSyZU1ijWmFWt6YNSa8S9Q2MrzDwNBnMzPPIB/oXgwKc2AOnuIA9QbRU+CnZAMFUKmsEKCvAjHa1CMi6GOQ76bLE7YF/Jgg8609B99w51cnQHtjHCQ2ZL9h1iTHqv8=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2683.namprd12.prod.outlook.com (2603:10b6:5:52::19) by
 DM6PR12MB3145.namprd12.prod.outlook.com (2603:10b6:5:3a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Fri, 11 Jun 2021 03:36:47 +0000
Received: from DM6PR12MB2683.namprd12.prod.outlook.com
 ([fe80::8823:a421:c7f3:83eb]) by DM6PR12MB2683.namprd12.prod.outlook.com
 ([fe80::8823:a421:c7f3:83eb%6]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 03:36:47 +0000
Subject: Re: [PATCH 2/2] x86/mce: Add support for Extended Physical Address
 MCA changes
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210608221012.223696-3-Smita.KoralahalliChannabasappa@amd.com>
 <YMH9wqUnjudiAVlr@zn.tnic>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <1c21d3c5-8a5a-31cf-6d84-0905a0c508da@amd.com>
Date:   Thu, 10 Jun 2021 22:36:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YMH9wqUnjudiAVlr@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2601:204:c502:3ab0:9a30:e601:e882:30d1]
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To DM6PR12MB2683.namprd12.prod.outlook.com
 (2603:10b6:5:52::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:204:c502:3ab0:9a30:e601:e882:30d1] (2601:204:c502:3ab0:9a30:e601:e882:30d1) by BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 03:36:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f41aee-a047-4f85-47e2-08d92c8a2403
X-MS-TrafficTypeDiagnostic: DM6PR12MB3145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB314534340C62F06F9AEAA34F90349@DM6PR12MB3145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaJuqrot+LppgR2rpBONWRi9cWB1SZ/fREsNnzc61S+2qm9JFa5mCQ60KCWa0MArM9TQh9NGMK3yjo6wwWxnbTUxahIYSyZ1mbm62KfMdf0v62dJOtDbftv1x9k/WCIT+F2cy5qcNhrt0xuo/52rOFjsUNFCCG3Meg5Xbpq8F09rJV26Gpfyh8VhH+L6CumZ8j06Bgk7x3UocPw/i/mOqc0+YCLGAa2pbBkF8ROfwtUdVv8XyJUWD6ZYHgeCM/mikfqWL4qpYsLeRUILNwHNe8eewnMx5cS3DhUt3+Me4SffxZDaHpGfYKnnu1EJPdZhrWlbCL4V9XMLuHtAopMXjuz2Lzj8j/h5ArmTQjq6hHU8RzRBcIU3w37mNJdLjPfFzlZTLLwnh2UZDYKykx5+5kCOWqeGNorP0N4DYfskFo04QtIL4tZWhtOnDuXdU2xGXRWjA5hm3hJL8o/dvH8yiYA/VLksWX+O6G3B5T11JUanTKp58Z20ghe1+CBap3AOpfGeA1W9R+O66+MY3SLVW6QagFJI3NGw4nNYWPso7cOJQyvdb4SK4StE9Nsq2i+jxhSjzeZ2jcNkK346lcVYOg08gztjXb8CwdTiMgesAfeoDOMJ7TL5VtCFSKiQuQdqij6wFtC1x09xdWvRsjzbDTFWCVbfZ3GbgE32m6SFPAEiPXbSpUM2RUryxMX94rAi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(8936002)(2906002)(36756003)(6486002)(8676002)(52116002)(38100700002)(4326008)(186003)(2616005)(478600001)(53546011)(66476007)(316002)(66556008)(31696002)(6636002)(54906003)(83380400001)(7416002)(5660300002)(31686004)(110136005)(16526019)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXkwNXByTlh6OWJZOGttaGlSYUcwVUVRMzNpQkxWM1VsT3B2eUR0d3U1Qml6?=
 =?utf-8?B?b0MwNWJ5QmVTdFozNk9RKzNSdDI3QmcvL1FHWTk1dmQ4Y1FjYVlsWEhmS3VF?=
 =?utf-8?B?M0NVRm5FaHRuTmIrL1E1NU5yUkRKbkd3STNVZElPbmFYaGFBQ3JVVzQ1NUdE?=
 =?utf-8?B?eXc4NVpXajlOdjVQNFl2OFdXa1lsTVgzWmVvQlhjVG5CaTdCQXYwdExMWUJF?=
 =?utf-8?B?WG92bk9WUVFPa1NwckJ0eExGVTdscWU4QzhsakR5VU9pTzlkbTdUa0pBMTNs?=
 =?utf-8?B?R2NteXdUc1BWeDFQWmFvWWhKTkVCWkJMVkduRE5TTzlSVEdqamZHSENIdjh0?=
 =?utf-8?B?VlJZSDJkeFMzdXVxNDBQcHhiTTJIV3hubUhqZE9mZFVReEF2dzlUY1VVN2ZX?=
 =?utf-8?B?Z1F6dzk4UFJ4RTcvYUx3WGcrM3diM3l0bFE4TlRaT1ZpblpBcWk3bzh5UE1X?=
 =?utf-8?B?RHR3WDE5MXNKVW85Y0ZFWnV4ZWI2Mlh3RE01aVF0YWN4bnpVZXd1SHAyNEdk?=
 =?utf-8?B?TUNXNUd6bW1GbDFxMjBjMGgyV2pKWWhua0dhdHlNa2w5NGZySER0TVFrZXBI?=
 =?utf-8?B?dDJGRWVNYU50SXFyWkdhZGJVZTVpMklWdXM2QzFRSnpoeFpwRU9DbnVXWHZv?=
 =?utf-8?B?V3krSTFZay9iWVhiOUpyWEdCWU9sS2NLdXB2bUFzdlk4YWR1czNRUzhZcDhJ?=
 =?utf-8?B?SkZvSHlmSzFUeDEvYWhWZmxSRk1pMWprdnJKbllvMkY1aTFJRndSZ3hzc05C?=
 =?utf-8?B?elM0b3JWcUtQVHN4TkRYaWNUQzg2a0xGdWpGNW1UazFyaHZwQitxOEZYdkl3?=
 =?utf-8?B?WXVpWjhGZHA2amJtd2RkQVJGT2Q0cVhMbVlMU1puNTU2RWtycHdHbEtNa1dH?=
 =?utf-8?B?R2FPUGI2SU5aZndtOWxxaFV3TkJLUC9tMFdkZnpxb2cwb0RlVE9ncHV0Wlp6?=
 =?utf-8?B?bnBxcEtTUy9CQnZMeVRML1VFdDg5MXZ2cndZYy9hbGoyUU9GeGh1VHRUVzg4?=
 =?utf-8?B?OXdxaHJhcUVCSG1zbDdxQitYMGx1dk1RV2loQVBUdWlLc21NY21FTU1pMnhI?=
 =?utf-8?B?RUZxdzJZQjQ5WWs4V1FxdEx3bmtiZmtKSFRISENsRlF5YlZmVGFHMmZYaEpW?=
 =?utf-8?B?VlFic1J4KzMvc0tLRGd3KzN4TFVMYnR6TzgwdnYzL1hCeDF0bDRrTHppTGo0?=
 =?utf-8?B?aHNEOC9hRkNFaDhTVExRUENucjg0cytVVVorZjVlSUtqRjRpK1VnZHVtcUNu?=
 =?utf-8?B?UWVWZ3BmSEJpUS9HTTJSMVhoYStLZ2dJcHJRdEk5c0dQVDNJWi9tRDhZdVBh?=
 =?utf-8?B?ak5va2FTZWQ2a1JlQTdueDlNSTdDQ2RRa25nOXYwZFlKT21mOE03Tllmd0do?=
 =?utf-8?B?ajg5bHJUNVVRQ0lmQks5WXZSdWFUWWlPSitNazFtYlVEcXdtWGFZTEFDVWlk?=
 =?utf-8?B?L1NLTk5UdHlnL1Y2RTgvbDBnblNiTU50NFRMR0IzZHBvc2M3RmtobkJZSmpu?=
 =?utf-8?B?NDNuNmRxamVleFFYV1c1R3BzTnlBWWVJbFBvc0tkOUdiRzNPM3ZDRkpSY2xu?=
 =?utf-8?B?OXA0QkRHczBYQnRESGRwWXBmTkxhSmc4KzIzYy8vVW5YV0k4RTNxOWNWS002?=
 =?utf-8?B?Q2Q0R0haaXlGdDNPdGxSVzZoNnpwQU01bUcrNXhtRlZYMnU2T1JUVmJGdGw5?=
 =?utf-8?B?UlBCZ0hvVEZaNTZtQkdzL3poRFJoU3pmVmpjSExMUXY5Y2REeGFsZHB0N1Ju?=
 =?utf-8?B?NXljQVlzRDlBQytSTXlNMElET3BnU3JUdUtLR1UwMHpvWTlCUVpwelArS3VW?=
 =?utf-8?B?L1NJUktWZ01tenNHSlVYRXA4ZmRMTW8xWHRqU1kwTmdzV0NGMUxaeDRtc3pi?=
 =?utf-8?Q?K2Yigd4FMHX57?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f41aee-a047-4f85-47e2-08d92c8a2403
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 03:36:47.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zzg3felXMAQVD3644eiTftO6yO3aeGdmOa/fkvFnFX4/z+lC6LaHVD9RGyoZLCMTd8nmL+8Vztwvusp4iK0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3145
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/10/21 6:55 AM, Borislav Petkov wrote:

> On Tue, Jun 08, 2021 at 05:10:12PM -0500, Smita Koralahalli wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index f71435e53cdb..480a497877e2 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -204,6 +204,12 @@ EXPORT_SYMBOL_GPL(smca_banks);
>>   #define MAX_MCATYPE_NAME_LEN	30
>>   static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
>>   
>> +struct smca_config {
>> +	__u64 lsb_in_status     :  1,
>> +	__reserved_0            : 63;
>> +};
>> +static DEFINE_PER_CPU_READ_MOSTLY(struct smca_config[MAX_NR_BANKS], smca_cfg);
> Per CPU and per bank, huh? For a single bit?
>
> Even if we have
>
> static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
>
> already?

The idea of defining a new struct was to keep SMCA specific stuff separate.
Thought, it would be costly to include in existing struct mce_bank[] as it will be
unnecessarily defined for each cpu and each bank across all vendors even if they
aren't using it and would be a problem if they are constraint on resource and space.

Also, in the future we can use this newly defined struct smca_config[] to cache
other MCA_CONFIG feature bits for different use cases if they are per bank and per
cpu.

I understand its unnecessary overhead atleast now, to just have a new struct per
cpu per bank for a single bit in which case I can refrain defining a new one and
include it in the existing struct.

Let me know what do you think?

Thanks,
Smita

>
