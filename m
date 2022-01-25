Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13A249AC10
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jan 2022 06:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiAYFzd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Jan 2022 00:55:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44568 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237554AbiAYFwN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Jan 2022 00:52:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P1ZLnE022850;
        Tue, 25 Jan 2022 05:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=vsBcqelXqMImAhzK8aIgi6ri6Nu3urz0ed4+SngCWIs=;
 b=bbB9kg7Oe/fRt1Gs1osnFAPsD9V0myrv2w3E4U9D9vmrkq6kf9AJBwAN59YRwpAqAyS/
 kj91pilmiQJS6x9gCsAz00iW9RSU6u5Vo9/j02vuXDGHXLFd5jvUvCrN2E42SET7Domt
 MYIftO9wKYbaomkp0AuXDQG2G6sEuDP4yF++Wh9Ngkyun19cKVOPF6hdSVQOBfII3Ymg
 jizTBuq+KQG4qrsJpFDZBaV0mqD9vd2mroTrqXxMKLqJGspSoU10mKVhj2BPoGmloFh4
 ZdQ/01PfSSsVf+o1bNf6J7+1eT5CAWR464mGx1TAtQVg/P61KCLbzQu8uBYkeRc4odgJ dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjae3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:52:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5khnu101054;
        Tue, 25 Jan 2022 05:52:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3020.oracle.com with ESMTP id 3dtax5s623-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOXdazTDq5mqTOV/EYJ8wToU+PRU4BtU5T4bEPtzdwLg+Jdr3g/iTREU00wLMhxMB1xAjb6PccfJpxWq9eV20H6pyj9gN2neueGJDn08f3DYMzseLEFN5HSnzy13jCOMrjMMXG6guAVxHD5BLWIfTsOsVgZJu8qICm6edGywy7P7Pog9z9hsmDdaNUH+pU96e+Rk7AnOoCSGwgZotwYWcZvYNHaV6hXARosERzzLOan319lS8/qWSH2txS+6D6ClLC9rbqNIcAa75IeMDpOFH2b8hcL5rvGzhhXiLUvempnGwaAMkucu5rPk2axTuAwbVmlhvCMDKc2GFKDRg/QJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsBcqelXqMImAhzK8aIgi6ri6Nu3urz0ed4+SngCWIs=;
 b=dAvYD7sBknMY7ZiiPBO/Zp/yOcAgu+ywxlWREAamy0FizjYfnitSIovL7Vb8Ow6ocRmabU5Tx9Y9Jkykpq7yTj7MVFG9og971/LgJD7wGbGKb/eG+erO9CXVcvlaQG32iS17yq+g1N2HXDxE0ku7x3nAiZG1TXNlnL52pL068R7PZTxn0/c8JkRO3esCD4Pv9Tiibe/yk3bKPRTjJFbbqNBZIo8XU64yKcHzMlfRhLBkv8CztQ35s/7cT4iTiuUZDUIXP6XjgUxSydDlXxgU6sIT9ZoGTZhE1SvHufr/0FoThX67M2h1XiioP2BAXRrVWYyGRrjNp21tbIFnmvB9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsBcqelXqMImAhzK8aIgi6ri6Nu3urz0ed4+SngCWIs=;
 b=LOoPUDkAKmZPCjxO4c/adHBq+CwDq3/fzMVlvV0tqJrglZfw9gziqWheEZYpEPGa1HgKzIg/4H2rbTmqZfa5v88v2OP+3daZGxF7p23pQtpMSLMICfd32pevNTU4Dx0CCt2bSCYF5BMHg/YsNalz5C7vXymehTT9lHgn15e0yhs=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DM5PR10MB1401.namprd10.prod.outlook.com
 (2603:10b6:3:f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 05:51:59 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 05:51:59 +0000
Date:   Tue, 25 Jan 2022 08:51:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     qiuxu.zhuo@intel.com
Cc:     linux-edac@vger.kernel.org
Subject: [bug report] EDAC/igen6: Add EDAC driver for Intel client SoCs using
 IBECC
Message-ID: <20220125055147.GA30689@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::7) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a58c7d-e411-4706-febe-08d9dfc6cd36
X-MS-TrafficTypeDiagnostic: DM5PR10MB1401:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB14012B353D06D149BDEC82568E5F9@DM5PR10MB1401.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQquKZPbdZVESTfDyqpG5xXMTOL1L4EMgZq+CY9kfz7kqAiyeHhI3J5bX+g2vXZYROAk+Hm9vjN3TmgtzYJmpOp4roShXk/mJ3NqEsCxQ5CmxrOlBuQdrQ1zA04cBDlPUlETd/+rYTt0+M80OAhHCsWcR+tDNwQbGmLmjWxUz+q5Wb4/BMp579SmBNs48ha6R110PhkDP5tX0tvZcDcJ4W0IT5hb/l5P2Ik6hcYHnX35O/HYnQ0dw/UofpQhr9tCe6ldR8Iz4y1gmAXiz81oBPPE7jSm9NXd+GEJmF0/jYR5Fa522MuMy/xKGf8peQcEs16xWIcGY++zhEVw6pmwM2aYLlczxFtIfgHvnP4GvTjYBfFGNxlfncPZ9rFlg1tMzhIntQdGr3B4r2JsiviQ7ViZ9cR/QMjlLQWSEY6sepiRgpehEQ8K8T6A2amEE2klWSa+3bA/SP9VhVxAHivWewPQmuUnMwQGRwapk69doHGE3fbTiwGuk4WoORV2uk1RjNbOahJYXItqB0c+6J8ro8U7m3T0XX7tP4MX/mgsySQ28nfJcKA7fRiHTSDgJE0YP5NVG8++yOtTXboZsSfA/Dccm1bkjCy325hgrSjJMOGm3gSj5H0dRA8drpFNLzHhkKlffCfHf+J7muDOn6Yf+hwzPLRyRdwJjWtQctdK0oUARuyfgTaUSNIXYLSDk1TjVV6oRvg4Rwns3PjJ4Ql3Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(7916004)(366004)(1076003)(186003)(52116002)(33656002)(6666004)(33716001)(44832011)(5660300002)(66946007)(508600001)(8676002)(2906002)(6486002)(66556008)(38100700002)(66476007)(8936002)(38350700002)(83380400001)(26005)(6512007)(9686003)(4326008)(6506007)(6916009)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qQqEMdZyEGz8/lp1TWfalolhLFDXcy91hK0By9f8ekB3KnealyzlCkSW0iR?=
 =?us-ascii?Q?J7nVWdyjTdI3o6hsr0PLZ3/9F4/aJUnX6um0D0nU5Md4F87+6eC/NjyO78qm?=
 =?us-ascii?Q?ELcUTl/CWijfANgSGOkQb+Ce4bAfpPjwsxdIMivqu+oR5bs0Onwpd6gkFgri?=
 =?us-ascii?Q?OSzCdh4NjAb2bOg/wkv6oy/cmNKsIlHPNznOIs6VOo3zRHyIz90zgCHvcMam?=
 =?us-ascii?Q?zLREMZ38KMOsIfTEMJ+ny5Gzll49EmAP3Mw3HFHWouNOqh1qSa7u/u0vHYJV?=
 =?us-ascii?Q?xkgiFaM8REWD3lIw7R5opsJVocBWHNGRAHpfhJkZpK/5Tb0PKgTJJ6D7TlBr?=
 =?us-ascii?Q?s5ROrx8kc6BuVx+1BqNrUJtkEMq5FjxlhkwnacOYjQQL9iEmv4TBnUkRkniW?=
 =?us-ascii?Q?XiISK8jlZ06UMd3OdDnlK3v3Ag/KUKFKlgOIy054RYwShbDnr9TDnmMfNlN5?=
 =?us-ascii?Q?+3V9cXKjIS+5LLXFrJWzsNOS2YV5vZugXCeKfU4UahBbHUZ0KTe+li/w/t0L?=
 =?us-ascii?Q?h0BafWvhSn5HcnN0NLQhiOcbhcEw9KKQrUo2gJCu2c0hxMmyUM/UXqAtkISK?=
 =?us-ascii?Q?ry+KzXFFhSFeowZByVmaj8IWqOmBbaM+EdvG6VopymlEidsAjyae6ldgSETB?=
 =?us-ascii?Q?e4V5KSxAIbskzs+UeoO5AX4Jsow5EA/zGsju5oynFgbgIQri0gZrigwN3iyJ?=
 =?us-ascii?Q?tKFokU+GPda8i1jvQyyonmviX1u2DslsYGfn3nSx+drlAoly3RBV2k/l5FO0?=
 =?us-ascii?Q?ZgOk4ZLEoGjl1W/1wlIdkIZKKWzwa8OvEOdGtGD4QnA/H2QChcN2bxaclMfx?=
 =?us-ascii?Q?2VKvIKuSW9DW3HQUdXeU3WtHiostdpqBvacCGdjeQmCYoLD6KLdjN3PqdlNU?=
 =?us-ascii?Q?amQTk/OtIfv7DLRXQqZveKR8XuAeJT1Sf8PO0ne2s2fEqhra2xnUeDiAjuhR?=
 =?us-ascii?Q?GZaHwQi6UAbdA4/X6+lsyzUDBVe7l9/7mFxQhGwxA4XINd93Heb363LPoZfT?=
 =?us-ascii?Q?/EPclfIwQ0/COck0jt5BAkbV2iaYTEcDmaGDje6i8sj6bmSUhNvhO40+LAbU?=
 =?us-ascii?Q?IAhxMH+dlffaSJWztoW1dSQ6flPA0g80j7RIBnyLcI8Rsv2jmOi1iaNhJyox?=
 =?us-ascii?Q?pmsXMofBGv/QL/rgjMjWMbwCCi7bSb8l9tGuUVdb8VmMourJIWiHPj5kAvDr?=
 =?us-ascii?Q?vyeySewzn4VcPodnTaT65ORqXXvEQTq5u1ynCnR5XYDHjTSK7SA/4oDPR5Hh?=
 =?us-ascii?Q?tACh4JsPh8nzGw2PunXMZg/IwCpp2aUZfOAhUmxKi6RVxqi/grsstd2vCPna?=
 =?us-ascii?Q?7NgIC8smd/Wj3hwsWMFW+VSeUyCbvgziUMQiX697KlBdqEOyQPJHHvHeLydd?=
 =?us-ascii?Q?kz785L+/EZie2WOgCXWjmi435HSqGN1XI0A+w+rW9vaSezE8KYxBYn57WQDd?=
 =?us-ascii?Q?Egb8Zhu30Y0kMfsMWzANL4IIHGGs1bmex8rF7cBNQwcoaBFgH9yNiKuTlC7l?=
 =?us-ascii?Q?14mHy2GncDaubMT78nEKqRGvaccEL2uMODrqgRMf5h1UB098bS/XXuPkOD/M?=
 =?us-ascii?Q?JXrqAnvvGy23Ox6dPRGRbBAlRsmvbTkRqhFT6u8Qakg96B/hzZeJ1cfRVu/7?=
 =?us-ascii?Q?W/5+EklK7g4WUoeWkBbBcEO3VNPMQmDUcrkoq8QRBpdwwue06CRIzhg2Qv9K?=
 =?us-ascii?Q?GhxZl/01MoA4Wa6HTBsZQmI/SwY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a58c7d-e411-4706-febe-08d9dfc6cd36
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 05:51:59.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evhca7MtxPcyLTYWSwqyMdTwy53dYReN7qJNTM32findohFAmfUU+xT9dl0KHaCNwspVnwHJt5rbKuUGsWBhqN++YYxhtuU1Vju8D0Uaq88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1401
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250037
X-Proofpoint-GUID: XHT4qichFy1oa3kDaCBDpxP3D__2O33g
X-Proofpoint-ORIG-GUID: XHT4qichFy1oa3kDaCBDpxP3D__2O33g
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Qiuxu Zhuo,

The patch 10590a9d4f23: "EDAC/igen6: Add EDAC driver for Intel client
SoCs using IBECC" from Nov 5, 2020, leads to the following Smatch
static checker warning:

drivers/edac/igen6_edac.c:1275 igen6_init() warn: strncmp() with weird length: 10 vs 11
drivers/edac/i10nm_base.c:552 i10nm_init() warn: strncmp() with weird length: 10 vs 11
drivers/edac/sb_edac.c:3510 sbridge_init() warn: strncmp() with weird length: 7 vs 8
drivers/edac/skx_base.c:657 skx_init() warn: strncmp() with weird length: 8 vs 9
drivers/edac/pnd2_edac.c:1554 pnd2_init() warn: strncmp() with weird length: 9 vs 10
drivers/edac/amd64_edac.c:4266 amd64_edac_init() warn: strncmp() with weird length: 10 vs 11

drivers/edac/igen6_edac.c
    1265 };
    1266 
    1267 static int __init igen6_init(void)
    1268 {
    1269         const char *owner;
    1270         int rc;
    1271 
    1272         edac_dbg(2, "\n");
    1273 
    1274         owner = edac_get_owner();
--> 1275         if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))

Was strncmp() really intended?  Because this is 100% the equivalent to
strcmp() with no limit.  Maybe sizeof(EDAC_MOD_STR) - 1?

    1276                 return -ENODEV;
    1277 
    1278         edac_op_state = EDAC_OPSTATE_NMI;
    1279 
    1280         rc = pci_register_driver(&igen6_driver);
    1281         if (rc)
    1282                 return rc;
    1283 
    1284         igen6_printk(KERN_INFO, "%s\n", IGEN6_REVISION);
    1285 
    1286         return 0;
    1287 }

regards,
dan carpenter
