Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7C706A83
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjEQOE4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 10:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjEQOEp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 10:04:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7897A8F;
        Wed, 17 May 2023 07:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLsZ/+Vd2Kk24fEVOynQyk3LgMxRDE8UjXLncYx1QmUKherajKEMJA1ikf2E/X0kbExFZHST4WquOE/BqOA1WzAW9qC8g1pCYATXpXCz4obxgA6SqPR+Y9u/8VOBGcMVMMYLZb3mHjult9mYcD2KyhEtjpuUpwmeRYxgNGLkkRxJFjlgeMYJLM4FuQhG9YKdpJmvJ7Q9MGTvXukfp5gLJGFqukSdk3cRSd5HHdNvDylMcRoAYuclncj6Hho+uoy5ZWxQ06y6M0AXGZ9bo6uVx4tnliIezdgZnfXZh3BSR99QaEyeZMVPc9gvYXFJhawTqdym/8To2zQb8Q5H00RaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPfVjYWU+0f2tpcvjlGgNvSDcJb1MJl8n3amhC8DL34=;
 b=jJwsgJjJX1aOYyqaBjtfT4cAx9zYFiHD5dbq2LFGBXEnJy4hw+YpomORG4tMzD9K8kxi45DNR9MGNwiW00uq32m0akaZuWTAvVkaWy4s00OCRQwjk/pfJF1ZnpDlPvnL50z2m6DxcyzOG/FI6+DleoYabH+MiXZypNpDh6YXYWIYnUQE51Ygb/8kQ55vJigLl/p8vweS+OPgN6+kEvoW+/wP24LhjUagK980TbqcMpZI8fDLNMYwiCpaf/brYAYx9uDGI48j/IjfSLpzwlI2tq+gXRe/Y+RNLdcWjCDc8hTVZYweLfzBzCvpcNT5QpEUbARWbGlbQzJE/vtMFw6rMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPfVjYWU+0f2tpcvjlGgNvSDcJb1MJl8n3amhC8DL34=;
 b=GEdGRXxwCM/Z6uU3+GuQY+NseXbmo5MGBFTKxcjODnRfFa1QSeM+hQ27JQF+Y228MDkOz7Re1ymvo0GyY2iUKeqFeYvrj4PqbYoWx03BjUZqwSxu3s4mDHXDFPkrOYSg4bwmY/4EEHORI4/AV4+5Gds5U1vMJ/baYwKWORjFZxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 14:04:32 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9798:caa4:43e1:b93f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9798:caa4:43e1:b93f%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 14:04:32 +0000
Message-ID: <99cab456-5d08-931c-0d59-4415f822c542@amd.com>
Date:   Wed, 17 May 2023 10:04:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        markgross@kernel.org, hdegoede@redhat.com,
        Shyam-sundar.S-k@amd.com, linux-edac@vger.kernel.org,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        mario.limonciello@amd.com, babu.moger@amd.com
Subject: Re: [PATCH 3/6] hwmon: (k10temp) Check return value of amd_smn_read()
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
 <20230516202430.4157216-4-yazen.ghannam@amd.com>
 <f3cce515-845c-480e-a096-8e24e0079454@roeck-us.net>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <f3cce515-845c-480e-a096-8e24e0079454@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:408:f4::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6543142f-89f7-414b-0721-08db56dfa36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KaGMVc+oQlDSm7SVRGZuRWK9IquIcve+BP0qJjWRe+CTX+km7NHM5ucypuHZrGv+tl5thh75tiIHVS21kQOHQ038O1psafxiSKPr0jJzJRlAuIUOvnaaflwABURL8z4KO2zYGwQfvbKJfEkkBI7ClqEq04HjsEXRFkV2yGpfjuVNaaMx192wOPvqNlAjEiU56lKzP1feecv2eEt/glCqCEHTt9zSJDkVCkdSbq+jP4yz+3L7bQJgXfM+bHBX+wWQVWxDtHKVwDfbSqfD4lbdqtug9OkFvBQJidwV2xIft6MRf+oHSrcQ6DwhnUqacnNswUCgdLFTYl7hUV2X/MpViDwXOMBJ3Ud/y+uLtzZxINVdt0pAtoRZsr1bCIIhdJ6AOoPgCnbXo8B39uA1eGz0ZMFjwMTIDUCwamtTiH1/WLACGJ2Ts+R+VxnPfIxUqria1gReuLtUD9GGcC5o31OWrD9ydwcvtRb5DLqAnG/350AJGB9kgdZn2festZafK8lFzxQzme5n3aCA3Q3nB0AQY3sBRTZ6uI9TiP44rkGu5Dt3XvdlFuQbVHyOawy0QjtyV7wI9MH8EVbLAI+2BDwK3jM9gb6RUfnnqTITfzslBtF0+HiNQB/nR+eCcKsSI0rlh0yR58ZnIjLoN+0l2jYLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(5660300002)(41300700001)(36756003)(2906002)(83380400001)(2616005)(31696002)(86362001)(38100700002)(26005)(186003)(6512007)(6506007)(44832011)(7416002)(8936002)(8676002)(53546011)(66556008)(66476007)(66946007)(31686004)(6486002)(6666004)(478600001)(6916009)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVQOW9SS0NMZHQ5NlJSNjUveFNsYlY0RERZQ2w1ZmkvbFI1WFd4cG9uYnNr?=
 =?utf-8?B?Z2N3cWxFQkJ3TGliTGhhUXRKWFoyZ3IwSUNWZXVPZTRvZHhiNmRoRmtpc3k0?=
 =?utf-8?B?L3RscWxJL3NuNVJZZVZ1K3dtVlJYaHJ6RnN4WWxOc1lOZnU5YzI2QVJsWXVC?=
 =?utf-8?B?YUdwdkZoY2J1UjZRa1JpQmIycmhuQmd3WmFZc0U1dmNsOWFpSU0zR2pWWExx?=
 =?utf-8?B?Y2FtcjhJSk42TkxWTUdWbmRuY1ZHT1FOT2FvK01JVmV4WkM3VTJveHFDOE1Q?=
 =?utf-8?B?eklSY0I4Qy9xTDRkUSswYURJbmlleXFKV2xyY3h6RWtLdS9oVlVBbmRPa3ly?=
 =?utf-8?B?Z1ptcmR4SWE1UlhnQ1doV2h0a2Zxdm0rQ1h5YlRkRWtzUkRnUEEySUY5c2x6?=
 =?utf-8?B?RkpOeGN0d0cyYTF3L3lLQjJFSGROMWVyMmlEL0RxZXYyZ3djNjNmdGtDS09l?=
 =?utf-8?B?czUzS0dKKzkza0g0aVJ2dHVMTm0xV1BXTHFFazVZRm8rTkFiTW1DR2dOTFVt?=
 =?utf-8?B?MEdaa2NyQUxVRzBjSEw5YlloK2NEUTRDZWFPOE9qRzFOVGx4T1dXVlhSZUxs?=
 =?utf-8?B?N3hXNGhiZzltN3FzeWdRNTNuWVJ5WDRZTXFDdlZTZ1p3am5va3VhbVZvNmdn?=
 =?utf-8?B?eUUrYjZjVFRoMHFCaXNHdDZuOHdrRVhsekN6d0lXbm13SDluWVZqWjNzQmE3?=
 =?utf-8?B?VkJZNFY2UTQ0SjF0QmcxUEp6eG1neTZxeWJSS1EvNWZOMHh5RUZxTm1vK293?=
 =?utf-8?B?V0Q1d0ZwRzE3VDdLV29UTUZRT2JHYkpWQUhDQXR3TVEvRnFodWl3VDdmT1NI?=
 =?utf-8?B?ZWRjaTdMdTEwZ1VFWVZ3V1BkM25vbTBwUHphOGxEbS9VbzRTQ0dZdld0VVhn?=
 =?utf-8?B?UHBnTzJ1dkJyTmFMbzFaL2dPN2JVR2hUR1prcDJodXc4WVcraDk0dWZKc1d6?=
 =?utf-8?B?RDExd1BsNkMzVVF1UytMZjBJVjcxQXJtaytnNXlkdGxrVCtXVGp3Z1ZwVFNz?=
 =?utf-8?B?amxId3Ewd1BUVFNYMGJQS0pTTEFBaU41MXhSWW9EaDhzbXpUWElkWnJIeER4?=
 =?utf-8?B?Z215bnpGRkRCSGJjVGdkWXFKOTJteWRzSXIvZ0FVaEYwRXJudEh2dDVtRjkw?=
 =?utf-8?B?ckFWYm90ZS9qbXFRQ2xuN0w1Q0xEMm5pTWhzK1hWU0RzcjcxdG5kWTE1b3pu?=
 =?utf-8?B?UFdrVnhSRDZycDlaNDNhdkpFbUMrMk9JbkdGcG1VZ1h3Nm05Ym83QUxrR3RM?=
 =?utf-8?B?S0NDcVhpV1V0OFBmNTF3RTJmRmR6N3ZrWUVzY1VWWitsMTg0bWhxUWovZXFu?=
 =?utf-8?B?dURpK013M0dtMXQzSXlmZDFmb1FKWGYxbXd2YlkrWlEwaldDRG5ZM3pnZFAy?=
 =?utf-8?B?RUFUN2RIYnVtQUNxMng1SEhhZ3JEL2VNUXJWZkh1dWxXajJVRVIzcmFaeXBM?=
 =?utf-8?B?ejZXdzhyOXhleXppYmJ5RlZJd1QxMGg4eHNpdFVCYm9qN00rNGJ6U004R3g2?=
 =?utf-8?B?eU5OT09yUTFQZFJveDlHVnh5M0YwRnhvU3FwNDc5SzFRYzNucXdKT2xNNEV5?=
 =?utf-8?B?YW9oZlVCb3JqeHNjcEhSVUdwWVRCOUM3MDdFclVkeXhyUEFRQVV6R0JPYzN5?=
 =?utf-8?B?M0Y2U3BibVFPOW9BeVE3S3kreS93MlByL2VycUtlcG9raXZaZVR1a1RUYm16?=
 =?utf-8?B?dWFSVmtiWVNlUHluZkNBVzF5SjhEMk5pYnA5eGRnMmkyckVkN0lwT3RIMkNq?=
 =?utf-8?B?YzAyYnc0Y20rRUM3RFZpSWlFU1dYNjZUK1FPMGZ1dGZXK1k5QmNzNVcvS0xP?=
 =?utf-8?B?bDRqaDdUMURJVDZrdS9vY210QmFURGZOMDlVQ0ZxbEROalJUaGdidGNrM1FD?=
 =?utf-8?B?aE5XalphbGpWREZEOVNNS29mMER3eTh6UDNFLzdNVFZiNHliaFJnQ3M3bGpy?=
 =?utf-8?B?dis2dThaazhZUkJmOCt2QXc4QjVQWTVtZ2ZkKytjWHZZNUhLU3kzOTRYYkU5?=
 =?utf-8?B?d0hiT3pXMTFjcDJ2ZG9aUmJYS2lPUEI0cDZWWEJOUTExaWhkRTFZOWtXUnVB?=
 =?utf-8?B?WmVMOEhKT2hFemZNVWFFRzBkYmtoQnBMR2dORjJTN2xyQXI2SWdVcDZmZ0I3?=
 =?utf-8?Q?GaW3ztUo2Vc21DZWVs6maAmVR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6543142f-89f7-414b-0721-08db56dfa36a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:04:32.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAOFQ67kWwsIpuXJQ9Klu2QxOvtWs5M3bFNTDMcd1aXpIYASUYOiBs2zLzTdhvYda/oMjTRaLh6jc7IREJjIng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/17/23 8:25 AM, Guenter Roeck wrote:

[...]

>>  static long get_raw_temp(struct k10temp_data *data)
>> @@ -213,9 +214,11 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>  				*val = 0;
>>  			break;
>>  		case 2 ... 13:		/* Tccd{1-12} */
>> -			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>> -				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
>> -						  &regval);
>> +			if (amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>> +					 ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
>> +					 &regval))
>> +				return -EINVAL;
>> +
> 
> -EINVAL: Invalid Argument, supposed to be used for bad user input.
> I don't see how that would apply here. amd_smn_read() returns
> a valid error code. This error core should be returned to the caller,
> or there needs to be an explanation why this is not appropriate.
>

Understood. Will change it to return the amd_smn_read() error code.

>>  			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>>  			break;
>>  		default:
>> @@ -373,8 +376,10 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>>  	int i;
>>  
>>  	for (i = 0; i < limit; i++) {
>> -		amd_smn_read(amd_pci_dev_to_node_id(pdev),
>> -			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
>> +		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
>> +				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
>> +			continue;
>> +
> The reason for ignoring the error should be explained here.
>

Sure thing. I'll add a code comment above.

Thanks,
Yazen
