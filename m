Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289997B8073
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjJDNO4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjJDNOz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:14:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E2A6
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeKCeGfES30Zy+sCAwXGqBPqOV0MuXq+PQgv2J/PvJWjcNQ2N4qs5gIIGStm8+eSBV8S14LFgUYmRTiDNtvAc/fSn36xCfAnN1/RrzdvICH52Rj2xVyxNnS9PqVgE3saGd7YanWoe+J2OFKcVPwgeD8wlQJ8OlS/HmVbnCFR8J0aeO2Pf6riJggnwEQ84gFHmz0FVd7CpeQhaNRi77YhrpFIl4Bsunuex0sWVeXpYXn01WCL8rJVXLeVIZglblzBv6myYca9J3prTuHGW/T36eDrrxcTj/ATIuYdBh9DqIGMMMbnlFToZlaojvcCRKzoYh8FG0a6Gub+qgZPVWc0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlIsG9NVVLoWCwpkA0E6KiyJhhzbyn2H/wrqHeD0qE0=;
 b=YgiQgIOLIMV7s4E0fN5vHA3cl7UU1IjlSj2nkEsnkRraEJie1T1Tvg8m5NrdAwva02NB76ccmsSqgga2JpWq3Qcq77SzdvtVZU8ZpLnhY5GbJG//7HAj57yz8GMFB5JkKEygIxr87QkWnmOkUK6OD1NXrhcvAbWGx+pCfvKI/C03ta6GzHvDWl0k61JkpAJTxR9SMf3fKejugDkHSwqNKfj+reYJ5Juf0V0TgEx6kPS483tQuW7efaN3HM3gLLahE+zmHFgU32xVf4b7G1S88xxRWuxMWmNxyQLYYiAnFhLuONOQhoLt/Q8qh6qJfhR5sCWOkGWQ6CcsB7O0DA91yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlIsG9NVVLoWCwpkA0E6KiyJhhzbyn2H/wrqHeD0qE0=;
 b=QnVOle8bdqeq0LLsSSnXEH0iua+bQBdA36sJpR+PwPxt1FuYFciMfqQXJxut8ggYCvRbD4DnSy2Mx9WFd3C769wpx4qsYuIOCm+iIo2+ci2gmpsIrS7J5lUxrn6xeMSKwm9xb7u5HzWNYwBVj4+ACCn4tlTn9FjWD/PZKYtDjcA=
Received: from CH2PR05CA0047.namprd05.prod.outlook.com (2603:10b6:610:38::24)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 13:14:49 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::f) by CH2PR05CA0047.outlook.office365.com
 (2603:10b6:610:38::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Wed, 4 Oct 2023 13:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 13:14:48 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 08:14:46 -0500
Message-ID: <1432a281-9d75-4f4c-9971-818d062c9df1@amd.com>
Date:   Wed, 4 Oct 2023 15:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] EDAC/zynqmp: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
 <20231004131254.2673842-22-u.kleine-koenig@pengutronix.de>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231004131254.2673842-22-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 085fbbb5-0c10-4e1a-b893-08dbc4dbe2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlQPj9Qhu9OAO1JeWtWzdhOvMlWK2vBR3ZFR02ZwzIKKG07fP0MPgJEIEtqDWDry7BqVYnGBka2v9JjZlxZlhl27BshaXbWsSAUCovAfubjCdTsjkDF+dxhmp0y3D7sB6RtS/SuoIvFpk+aBfhAf1IuEapoCaU5525ukZLTU+Vx5Xp7wfSx4Kh7qnW43lRzdpIMRVplI3kpZufdgh8jqRVbVdYHK0+xUhlu2g0T6DCSSVOVWJ0ABN9M1NlImxsM1KfOQr0E8NiFFWrUNPdL2HA0OiFshtYLttnJ7oiT1QjNEomCqpbf6pYkFbqKEfC3BUOdp6VJNnhS4b9tYZnIOW3LUHTRsxP0Pjkv0d6wUdUAz7wyj1UQKIZF8XyVfl2Sk4fruRGDRpwC7MEj2D5uakxLWgiyex7osLahP+wJPA+d6UnXqApHM/joeLNNyQ/vmZIDyXbv+U7SLVMUxAeP2hNmReLX7orz7fBDzuh8QiXnULk6l8PoTYAc6S3NtIpEut6Ww101z9N0G5/GxYyd/euszJuVJ9yFbFkUTsrrVb3AsIpQRcgRYljVfPAV+c5/Sp2AEcgkFvAp8yCcm4QojmVE2hp/baJBRVBLoqLgAZ/8OqLzSdL2tsT+dBr6cjVZgNcpbdWuySpUh5ez/uVtmOT+k9fnCbYnlwfsmErGsPxuJ4620iDvdd+E3+cHuXGMp54FfvwTeormdpmou9If0h9VoopHQxC+0iKr/OPIDP1dl4rXcnbU6Mc87QNMsk5/pFgVM6TCOH0YkDXJYgHW/KFYw94zhs66St0EPbn3cv+kz8f7MwKY22TCOgGvJClp2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(36756003)(31686004)(40460700003)(336012)(36860700001)(66574015)(83380400001)(44832011)(5660300002)(4326008)(8676002)(8936002)(2616005)(16526019)(26005)(426003)(53546011)(47076005)(82740400003)(356005)(81166007)(86362001)(40480700001)(31696002)(2906002)(478600001)(110136005)(70206006)(316002)(16576012)(54906003)(41300700001)(70586007)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:14:48.6609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085fbbb5-0c10-4e1a-b893-08dbc4dbe2ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 10/4/23 15:12, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/edac/zynqmp_edac.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
> index ac7d1e0b324c..2d9a5cfd8931 100644
> --- a/drivers/edac/zynqmp_edac.c
> +++ b/drivers/edac/zynqmp_edac.c
> @@ -426,7 +426,7 @@ static int edac_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int edac_remove(struct platform_device *pdev)
> +static void edac_remove(struct platform_device *pdev)
>   {
>   	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
>   	struct edac_priv *priv = dci->pvt_info;
> @@ -440,8 +440,6 @@ static int edac_remove(struct platform_device *pdev)
>   
>   	edac_device_del_device(&pdev->dev);
>   	edac_device_free_ctl_info(dci);
> -
> -	return 0;
>   }
>   
>   static const struct of_device_id zynqmp_ocm_edac_match[] = {
> @@ -457,7 +455,7 @@ static struct platform_driver zynqmp_ocm_edac_driver = {
>   		   .of_match_table = zynqmp_ocm_edac_match,
>   		   },
>   	.probe = edac_probe,
> -	.remove = edac_remove,
> +	.remove_new = edac_remove,
>   };
>   
>   module_platform_driver(zynqmp_ocm_edac_driver);

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
