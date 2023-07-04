Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35EA7470AC
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGDMRU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 08:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDMRT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 08:17:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09FE70;
        Tue,  4 Jul 2023 05:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOejeUh+CLS9fhEqtzp/KHobkVqdhmCRAAAV1S1bSAIFy7Mcnj8WNfxWZMtGsUiG+cN89jlxNiIRaCJQefe859QAKIhF/Wzrm2bKxNmA/tft49KVK/2oo4QvKduZZH7XZI1vNH7JgVt+2eRBph61wP/USWlz0SJm1PdWACBDLIPesuTI8sbVzoFGCzCPMx1yBYcT0YVdy9O4CBvcbW57I2rmYryRl3u8foIQuh2pAPOsLdKMDt4GZ8t3pAMEsWn6Hr1iyaEvnCcB9uIN73wbDn7TuEwWrBF+iHaVefo9CamaEQGIAwm30LxfiJ/lEYSykr7LXuONzANUMJmQbWtjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnypTb/NYjXOFzgJ++PSaHFgoD/NiaGjs5D4zvI91d0=;
 b=JmOGgkW5e3A1BEmAtOYYFU/c66nJlAy/Pkp8IrI6yj7y5ZDlJ/o7NU5Z/0mkKs9qOSiwGA03EnyTVjBmIATN3Pz5MXkJeqdi3FkdKyeuF2zE1rwyp2DWY8Zmp8T3EOktN2XLpSqJOoPnBFJ6NrTU9Zz9dJ6FZIiTpT51yNqzV0pgmtgWo0yw03y02L2S3GfMb8eiMFFB5bR405UuvcE3Hn945T8+phZbnCZQ1jnyiiVvU2ScUYZIV8UDa4473CAwpZLQNSwt7WBHVuFNkslVm/PrsjuDvEsUbv1Dw0EVRN7lHvpWPo2unv9freSf5H1MHBlh4rseWrYU8x2TfwVKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnypTb/NYjXOFzgJ++PSaHFgoD/NiaGjs5D4zvI91d0=;
 b=c1ZDnGl4t5U79I58tnYb2y9yh6BXbiWliPb7IufjTYR2MSTtaBsDsrdzQ/6wjeIT1LgY+hlrSSmVxw7GZ71xqnxz/bNZp1PDHM3LVNxBlpW3pn+dFA4FB5HQavTyOZ//wKO4Ar1R5MPVhyKC7tJ3SQaNugyhdyVuGXtQ0YYTXhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:17:16 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:17:16 +0000
Message-ID: <7765c981-7ea1-60a8-a297-7f739ca9a458@amd.com>
Date:   Tue, 4 Jul 2023 14:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/5] EDAC/synopsys: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230704101811.49637-1-frank.li@vivo.com>
 <20230704101811.49637-3-frank.li@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230704101811.49637-3-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 855ac604-b834-4064-5a44-08db7c889aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQrwGM0v9WcuYpQIPfQpirDvDuhu1besINK+mxRo+XU9yXmVfIkXmDIasmU5uVbEKvNAis3GQf63GaH32NB71oxywV+AbqQVmdUgrcwBPUz3A20oZQVGHJ7Oo7BDKh0QEJp27VaZUMyZbh+mxaX3t88j5A/Yi/Xb9hdfRlTs5Fo2rR79fpLh9MGQk/evBihww7X9o03cwvrw+ctlB3EMrqC9vMQQimazFLej4zy50+Yquj4ARVcQjwOD285af5gwzAamLM4TRYIZDVl9bicE3Cxa5y1mcuuvTVvOfy0F17h7XRpGKkNvVO63Que6HSnalNuHTWb0eO0mbBOJy98vViXgueatvNUzFdB/KZ4h/FJ9iajJNj2deq8cqlUe8NpnGXHqvjKGhpYtW9tz+oyieV+PJBExW2xDcmuGU6IM/hXEpWmJSldhWmrFCVO35euQ9tRNBvesiW/cKDQd4+sg1mya++Hl4zwpdj8+yKTlWMzXFDmzC8MWmJ9CUROJuSSnvC1YbM4TbM3Qjn7nNMFskkjhCYUcwp8XsbohT0xGZQWAcnTUcUJD8ColEGQns8RxNhc9q1CSl5J1tSAR8gZNWBJcabpkL8ozXRPcrntgQhl6TB+xPDWsKHoXicKtMO1MmsrZVKYhtzTfAg8VGJrtNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(44832011)(31686004)(4326008)(66476007)(66946007)(2906002)(478600001)(316002)(66556008)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(110136005)(6666004)(6486002)(4744005)(38100700002)(53546011)(6506007)(186003)(83380400001)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndaVUxIOG9IZ0p1SmtqUmFCcU9QWEVnb3haNEZlZjhza2xDL3RFVEpXcnBn?=
 =?utf-8?B?OVVBdDZ1VityWUlsYXJHZ05FR1h2MEJsNk1PYjdpN0NOOHh2TGViNFpmU0Mv?=
 =?utf-8?B?QStJcU10MmlKMlkxRnFFZTVNZU1UTXdwamlyd3E2SVlvVytZL0JwWUlJQklI?=
 =?utf-8?B?MmpyMkNLZW8wczhOTHNwWGNTYlhla0pVVnNRTjAzUlh0S3ZOeStML2QxUWR6?=
 =?utf-8?B?L0dXd0kzeVVHcFVzRndBQzdGTmtsWTZDeHNvZVJISDAySDRYKzV4QWEyWStm?=
 =?utf-8?B?dmtkMVlNVko5WHV4Y0R3UzFHOGgwZlN1L2ZaM2FSVjRrRm1MMGJybldqT2pP?=
 =?utf-8?B?bnZVNHRnRis5NE1uMEJzZTRSbmRUUFJUWkdQdW1qN1FCRkdNYVpING53VVVD?=
 =?utf-8?B?YXFWWHNSNURZMFRmQTB4VVZaZ01SNlZNSnl4RzBFZy9BazlHdkFYaWZaWTBG?=
 =?utf-8?B?bzd4clgwZTVSanBJTmQrSEtFNkFOcXpFVDA5YW8xN3FnQ0FIOGNrMG03Uzl5?=
 =?utf-8?B?b3daTXA4UDB3dG9nWitSK3M2ZjdGTVVPdjJGcEVXczBpbWxJTkpZNEFaUTU5?=
 =?utf-8?B?QkdZVXFDNmZqcEJ6NWJyZVpnVDRtS09LbUt3ZUJRNVNjUlNPL2V3Q1ZzOWx6?=
 =?utf-8?B?OW1FcnRIV0lKcm5HdVc5dUc4ZFZ2eWo0NWl2U2hqSXcrSEVWUGZ0T3JMZFVp?=
 =?utf-8?B?Q3NSdzZ5TnNjV0xidW5hWGRrOS9NR0NDWE1wRUNGSm9DOHFoYUhLQ2sydzRZ?=
 =?utf-8?B?M2hDUU5vbk5GeEMyUjVEN0c1YjdoQ0tIZ1M1b0dDTnlqYlpzclpiREJ1VzN6?=
 =?utf-8?B?czlIRzgrVDJQL2JiOFNzZTJHS0djS0l0UlJMZy9WZWl6QXBuZ1Y1Z29qTmZr?=
 =?utf-8?B?ZmZBMkhwQmdMYnZGNG0wdFhnUGdSSFo5MU9aVGFyVWY5OEVKdnpHUHRQNFh5?=
 =?utf-8?B?NUhzcHlBWWZMM0tteEpBY2FTdEpiaGRaKzB2azFMM3FCRHhTQnhnZG1ZUCtL?=
 =?utf-8?B?RGJtVjdJbnR3RFVFM2N4TXVSWEQrT1BDcTRKSE1TWEdrd2ovdlVwSWVJcVV6?=
 =?utf-8?B?dWpkd1VLME1iRE5NRWZJU0xaSU9aVEZ3LzBORnhSQ1dReEdUYjdCTy90dkxv?=
 =?utf-8?B?Z05OZmorVkVmd2VFRm81YVZ4Y0dKQmxjSzIvM0tSOGRTa1VBV2Q0MllGZWlH?=
 =?utf-8?B?M0hQQ1FzTDlHN3Y3K2V3OEs3NVUzbytJWHloemdvaHBvSTJlc2FlTHBPcXVk?=
 =?utf-8?B?c3FKMzE4Zy9xVnRhaHNYc1ZIS293a0ZBQXNKcHFMU2NwbDV3V1RFcFpSWVNn?=
 =?utf-8?B?SnpmSjdWaFB5OWNoT0J1UjMyY3VYMkdpUU8zdFVCZWZqTXkyTTJlTTdwN3dR?=
 =?utf-8?B?N0lMM1I1VWM1dVI3bWNrSlNhdC9VaGx3eXZWcjlJeUJxc2hrV1RXU1F2Rjl3?=
 =?utf-8?B?dTV2U0V2V1lLa1BuVUpsblFrMldPMTN4U1BOQmd5ZkZOeXlWT3I2UThmOVFK?=
 =?utf-8?B?QkV6T012VXAzS0dQN3crOXZBM1hyN2RXRW8zck9TSkFQR2JuUzIxS0s1NjI3?=
 =?utf-8?B?dkxMUUQ1M3R5eEtYSDJWalhkL0ZpTkJuUExVREE2RU84b2hjNWNoTU1TelRx?=
 =?utf-8?B?NUFQbC9xOE5UWWhMcjNkMFFjbXVsa2l2ajRXcGlIYm8zR1ZEVTQ0Skowekh6?=
 =?utf-8?B?NG1sM21LUjV3emFSemhXRS8wdWVwdERHenUwb0N6elBLN0pZQTNGZnc3cjhw?=
 =?utf-8?B?R25YVHRpU3JYeThwcnlBREdCQXFEcDJZNFoyRWxCbUN4dVVLeVgxbXc2S200?=
 =?utf-8?B?dndxS3lkQStHL0hESU9sQi9BR1grMmM1ZHdmeGVpODlKam5KdVFQSmZibnQ5?=
 =?utf-8?B?eVpEcGZ6MEhUZDlnUEdrU1JVTjd4NVR5RFp6cTNiUjBaUkFsYytvZTFYcHdq?=
 =?utf-8?B?T3lUZDhJcHowZGQrVEtMSVZsMloxL1VGNDBudlZmYUI5amYwdlRGSVRESWll?=
 =?utf-8?B?TkJQOTdveFRxRUgzZEVJTWtYRWZlSmpiZDIyYm9oYW5sNVhjYVp2ajFMdXVK?=
 =?utf-8?B?QzBUVkQwU0pXcHNoYlJzOEY1OWhaN0Y2Y0gwOVhVbU00aE04aFduYnE3Yncw?=
 =?utf-8?Q?EyTGMBa4kieYOQruPLz6J2tWm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855ac604-b834-4064-5a44-08db7c889aee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:17:16.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubXlpCpmAGkWfajkAKkgciu39kXiejySbFCxkFlJQRfQ3J/FkwFgD1toScRYvf9q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 7/4/23 12:18, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/edac/synopsys_edac.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index f7d37c282819..620861fb5231 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -1325,11 +1325,9 @@ static int mc_probe(struct platform_device *pdev)
>   	struct synps_edac_priv *priv;
>   	struct mem_ctl_info *mci;
>   	void __iomem *baseaddr;
> -	struct resource *res;
>   	int rc;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	baseaddr = devm_ioremap_resource(&pdev->dev, res);
> +	baseaddr = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(baseaddr))
>   		return PTR_ERR(baseaddr);
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
