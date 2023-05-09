Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7D6FC991
	for <lists+linux-edac@lfdr.de>; Tue,  9 May 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjEIOxP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 May 2023 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIOxO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 May 2023 10:53:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD1DB
        for <linux-edac@vger.kernel.org>; Tue,  9 May 2023 07:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNCZfgHwZE5zrMVPXdEaTiDv38bXji4pShtGU9DQb+Cvne+RBG+7JhrV1Mly7zoVllWi/sPvPOKMzVkmxFzZtW8RlKDGEkq9pUJPC2heNgnljdGx7a1S1jXwh1e0h7lXwun5RsJlGYSl4cWPLd15kJcOJxVS3Skhxjm3gAXDOj79eDitC8DPzas2Wmj1F2JdawcHbcEFyuFieehijt/6tnkLIaU3zf/fL1d+xi7s3R3E0636AJ8bzThYDck326i+J0U1sqpDKckZugOAyDhhjGRz1KjZ8uUuFM47tF6+EO/RHQInv+zvVe0w7qQnM7VWii2qOxArlUTdmCMGQZl8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNBgEQ9dh5U8aocdPp22s3UlkVi0hPJx0Y41V55QDdM=;
 b=OaRxapeF3DURzkBtY3tNWt0jh86yJVuXauH9sk/VfrRuPoqxfnoLfJxOKe0xkRgQq5Vg6+26Gzedc8dGUhfYl6GuneYAt1ZD+7TF/E6bPkBkIhoSmz7nmQAL1L6E0mq7U/++DGsf4ajPVmm5fAs8781T03/h1NShwpNJ6uEEXZuZmywHd2T8r71ttOUkCuIIq99PTHRXq4nEKD+vHw4ngEcQR7muBFakkMDq7K9KE7nyC9ZlCfkpOAuNqOjXsUbTE79hx++pHZPpx6G7glZFkMZfyzBrcO1dMvjZ+jK9XxFbktUz7y9Jm16OSEJ2/CP8ggZmnXb22wffIxlfsemosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNBgEQ9dh5U8aocdPp22s3UlkVi0hPJx0Y41V55QDdM=;
 b=Qkikc1cfrDYM+3gE3BKI68lhZcBJ4OYPec+k212nGHel9HGsgP3fhQiMX2zyw+2wBkmzmB2AacWnm/rpjBKgcYwFoNNewlagi7PGU+jJxROuWvFXRj9QJqUbxzVCznTt1audvZj52ICAMeIrbNnkUZNt/RgjyRNu4WPP42LD2bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Tue, 9 May
 2023 14:53:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:53:11 +0000
Message-ID: <1391171a-8f44-03bd-5e92-b98d2044b463@amd.com>
Date:   Tue, 9 May 2023 10:53:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Add support for ECC on family 19h model
 60h-6Fh
Content-Language: en-US
To:     Hristo Venev <hristo@venev.name>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
References: <20230425201239.324476-1-hristo@venev.name>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230425201239.324476-1-hristo@venev.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0481.namprd03.prod.outlook.com
 (2603:10b6:408:130::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f00636-094b-45d6-a57f-08db509d1b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MBKTO4EOYpPDbyyp6BN1UVpFjuPUcgSaLPixelMjK3s2lVPKiDmzgXwsQ3FhUh9JUMInhh0H4wO9V3KrEAWQMFgoZw+Hj7cQaw8N7zaD1B5ylv/ILuB3A159A/YAevJWNfLQbIgsgFwt7lRzf+fTOngtPpl8O6jPIS64YVioqtYOZ0yr/FzlRidWtZkpsIhzp+gffq+fesZR1l6wkaGeEnv7bzBqCRI7hPyYlJujrjpxQSzOiyURH/NbxClTKasiXvwMqIVaNlaFd5t0reim594XyGKfydqAWt90ME+aZkKO/m/mXAQV21ajh5vAQ4Db43PW99nGyZMuKzAmtBRynnArHRzD5uxN78q/zmejPoM1XmAfU98POWuTvy1ZVnwivvwqmWImkqFCvDIBkcpc+z4SaRqiozhRPpG+hRy7mS6YN7LtUM/bp6FWaiPr6i+nylUklnrvrvqFDC6TuwwpUBxjc0Lfds6PY6Cvw302cEnsS2V6avVZrQISUTO4cQaf9Zn4TuwWt+lOnjC6UcBb5Kq1wUgtWEEqbfJ0AeAHqs7vC74qS/AqFSinv4GJ/XN9Ths6PARPjfh4c/HUq8o5v3pCP233555wOPx4ibMQGJeqB4eYf8sAorbUv3eb9s1yjH9O9oA93lK/0F7UdSgwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(6636002)(66556008)(2906002)(5660300002)(83380400001)(38100700002)(6512007)(6506007)(26005)(6486002)(53546011)(186003)(86362001)(8676002)(110136005)(8936002)(6666004)(44832011)(316002)(31696002)(4326008)(66476007)(36756003)(478600001)(41300700001)(66946007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThRWXFKcEI3bnNZZGNhRkc3cW1NOGlmTW5ueXF5SW1lbThRNkxPNHV4TUls?=
 =?utf-8?B?Tzh0VTNIaFlVQXpVVzh4ZDNjYWx6bHFEekUydnFxczdLYWxzaUk0dmNuWVV2?=
 =?utf-8?B?N3ZPcHdnSFZwQjVpeTEwY3hYNVF3aDhrcXo5MkFUakRYQitQYUxWLzU3OEVF?=
 =?utf-8?B?bkFvUmFTejVkU0p0ejlPajJBcGFEcG1UU1JLY2hxTzBaUTNqNFNQWlREUTZa?=
 =?utf-8?B?L3Z3SGg4Yzl2OUFLcGIzZ1BRRU5LMXB2dGF2RVkvS1BPZXB6cXk3RWNCb1hx?=
 =?utf-8?B?V1pEL0YyNmJuOTlZWHNJY3QyeExSMUVhZFBET3JaS1Jrcmp1OVQyanBKbFNo?=
 =?utf-8?B?RlUxdFZlOGxhaTlXejdOK0pKNmE0THhvc0xEeHZ0NmJtbW9mQnJwZnlycG8r?=
 =?utf-8?B?ZDVyMlhlQVZiNFBwRklwT1VORGQzd1VTbC9KSmVtdnE2K2JNQVJXYS9MQW5k?=
 =?utf-8?B?dDBOTmxTZFl2Z09QVDh3RmFQenBqZnpvbklFTk9TL3VWdGJqZ1lIUWNmYkpz?=
 =?utf-8?B?SE1IN0lqSEVWc24zaDc3TitsWVhBdlFBOGs3eGdHMkJCWmNXVjZaRkV5MzRG?=
 =?utf-8?B?aTV3M2IwcFNOeGU1K2ZON1Z2QzU3VHZpbGFnaUdrcUpzZDd4ZDdtT3BxNHpS?=
 =?utf-8?B?SVdVbVY3TERiZWlnRUtWbUwrMXNvdENxNDBCc09xQml3MlpFdy92d1Mycy81?=
 =?utf-8?B?cmVUN01QOTJBZGlSbjFUSXFiWnRNMTdpQ0RZeDBqMXZ3cjNRTGpGbnpVNy9S?=
 =?utf-8?B?YVI4OTdiZ3JMYlZ2OGswVm03TlNuT2VOOElXcUg1cVg0S0dHZ2dudHNoSGdZ?=
 =?utf-8?B?SUZML0Y1SVA1ZXlldldPQStPTzZJUEhoSkN3Z2ZVNGRrM2FkaGlpZnZ1eDZs?=
 =?utf-8?B?UlhwaVhNNnJZMC9kNWlZVjhERmtyMUVrQzNQdHpQZG9sMnBYVEVZd2VkTVRP?=
 =?utf-8?B?bWl5NGVrQ0ZsNElITnFtSTJmUGMwUFlFR3l4Q1ZWYlVzOXRmbGJSbC9mN0Uv?=
 =?utf-8?B?RE9TQ1Fzdnlaa214NXZVTTNjakp0YTFGTWV0WE94SldxSE1ZRklYWkpJbVBT?=
 =?utf-8?B?ckhNL3pTQk85OFh2SDA2ZklDYjN1cHZsaStKS0ZPWUJwMDZtNFFoK2s4Qzgw?=
 =?utf-8?B?SUtiSmE4TG1jajNwWFQ5cnlFcDhlejFtUWRJUk1XUjNtL2JvNjIxZzVnbEMy?=
 =?utf-8?B?M3NRTkp3cWdjOW9pK2xaL21zeTZhZ0NMajl6WFc5MVA2NFRFcm4wQWJaRnk4?=
 =?utf-8?B?ejdSOGw0Q2lJSnhnTUxsYnNHdExmSERqVE5uM0loRDFZRWIzM2cxYzhRWks1?=
 =?utf-8?B?UWhmZTBNTHdhd0M5YzZ3TzFzLzNRSFVSbFpYVzQ5ZitYdHN0U2pzSmZ1TmZP?=
 =?utf-8?B?K3U0K0JLQ01iZVNZemw0YVJzNmdsRmtNS05YemhoSWN5OUpsVTZUazhsTXNG?=
 =?utf-8?B?RFg0Q3VVN2ZESXhPZDVNNFh2K0diUVRhaWVQUzBCK3VZRlR3UVlvTWRRbjA2?=
 =?utf-8?B?eHhmNnhPejdlYmRPUTJqbEd2eDNNUnkzZjE0bzd3ZURQM3hWSm5scDJ3Z2tD?=
 =?utf-8?B?TStMQ2RHZ1pHbXlVNitlY2hLUGMzbXN5ckNIcXhtbWIrTU1vOFZTcEtJcEdP?=
 =?utf-8?B?VnhnNk4zcHhsSlJjNStRRDhOeDA0VzlxVWpGZDZsaUtGOXRBMEo1WEd5bmpi?=
 =?utf-8?B?OEhISWhmc3ZXNi9xYmRXdU1SNTFWNkFmQ0p4OWo5bjRuV296VlZzRjNFbE5S?=
 =?utf-8?B?TmtWNzl0S211OWFCTXd2clNBbXBILzNEMGRxVTBDTTVzMk52RzFJNjZGU3Iz?=
 =?utf-8?B?QWhzUVpDUlc1UE1mdy9kbFdROU90djBLR0UvL3pyZWxxSU5NOVl3bzNZR1dw?=
 =?utf-8?B?SXR6V0JLdmNqYWVZVGsyRjFaemZLeXZJbWJ5blJHYjZaRU1iTlVQcEpUT3FM?=
 =?utf-8?B?cTVPUEw1eEZtNDhuZnZ5cUs0QXF2NnNmR3IzZzAyVFp1b0lnK3N5ck5ERUhH?=
 =?utf-8?B?c2EyazFQYkpKQy85MXJ6Y1NIOUhDM2JVanljcUxxWlo5WWFRbUNhb1hPdVVk?=
 =?utf-8?B?cjhXT1l5Q29xZ3cvZEpNaVdXcUMxdFc3ejd3ZmRiN3h2Qm5YT1Q3VzQ5eCta?=
 =?utf-8?Q?o3wagjpmRsRxkeasDnwsn9llT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f00636-094b-45d6-a57f-08db509d1b46
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:53:10.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fcNKhlgf7pKJZumfH+I17QLUetQAIuHmu+IdVFVr085huJKZTg8hUbHO1AHmKdSPYLaVY+UsycYevYcznIZdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/25/23 4:12 PM, Hristo Venev wrote:
> Ryzen 9 7950X uses model 61h. Treat it as Epyc 9004, but with 2 channels
> instead of 12.
> 
> I tested this with two 32GB dual-rank DIMMs. The sizes appear to be
> reported correctly:
> 
>     [    2.122750] EDAC MC0: Giving out device to module amd64_edac controller F19h_M60h: DEV 0000:00:18.3 (INTERRUPT)
>     [    2.122751] EDAC amd64: F19h_M60h detected (node 0).
>     [    2.122754] EDAC MC: UMC0 chip selects:
>     [    2.122754] EDAC amd64: MC: 0:     0MB 1:     0MB
>     [    2.122755] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>     [    2.122757] EDAC MC: UMC1 chip selects:
>     [    2.122757] EDAC amd64: MC: 0:     0MB 1:     0MB
>     [    2.122758] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>     [    2.122759] AMD64 EDAC driver v3.5.0
> 
> ECC errors can also be detected:
> 
>     [  313.747594] mce: [Hardware Error]: Machine check events logged
>     [  313.747597] [Hardware Error]: Corrected error, no action required.
>     [  313.747613] [Hardware Error]: CPU:0 (19:61:2) MC21_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000400011b
>     [  313.747632] [Hardware Error]: Error Addr: 0x00000007ff7e93c0
>     [  313.747639] [Hardware Error]: IPID: 0x0000009600050f00, Syndrome: 0x000100010a801203
>     [  313.747652] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0, DRAM ECC error.
>     [  313.747669] EDAC MC0: 1 CE Cannot decode normalized address on mc#0csrow#3channel#0 (csrow:3 channel:0 page:0x0 offset:0x0 grain:64 syndrome:0x1)
>     [  313.747672] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD
> 
> Signed-off-by: Hristo Venev <hristo@venev.name>

Hi Hristo,

Thank you for the patch. It looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

> ---
>  drivers/edac/amd64_edac.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b55129425c81..1080784e2784 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3816,6 +3816,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		case 0x50 ... 0x5f:
>  			pvt->ctl_name			= "F19h_M50h";
>  			break;
> +		case 0x60 ... 0x6f:
> +			pvt->ctl_name			= "F19h_M60h";
> +			pvt->flags.zn_regs_v2		= 1;
> +			break;

Mario,

Are there other Client models that can leverage this change?

Thanks,
Yazen
