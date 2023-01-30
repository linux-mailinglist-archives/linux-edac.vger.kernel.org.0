Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3568099F
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jan 2023 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbjA3Jf7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Jan 2023 04:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjA3Jfi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Jan 2023 04:35:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E73125B2;
        Mon, 30 Jan 2023 01:34:54 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U8sZRW026749;
        Mon, 30 Jan 2023 09:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : cc : to : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=/GcjR9poDff4SbzLKXa2SuCbPlqGI27TSL1uWa6ZqDU=;
 b=S6DyzgFwp5ydL9Bv83mSn+pSQXWGJFWudupDa2kijIA8ZkHdVanoIRCyBn0JM+a7pR48
 NH5r1/XOm0GPJjAIyLA7S4o2PQnx7l7LYHjRbOQaTOiQatr1H91AlYmPNNDlDIFC6fQx
 f7wZnlzOucfUtVbk6fIEvUsiKh5BFu6jZFbbTmzYn1k2hqJzZK7va8kSc5lGmFRnIWau
 kBMs/+HYipPSz7PN8lS5WaR6sjj7bJx56w2RpsMTWedIWvBKRK0sDeTwo/t6Oz7LI619
 R8nOa4r4gJQfEZD39XDolqF0A6Hs/hqRLhkTMWyAfr2A8Hr37DVnqbPoJS/GyTndRuW/ 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjtdha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 09:34:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30U9UejM019132;
        Mon, 30 Jan 2023 09:34:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct543xgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 09:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGXfn8cVSO2kTZ1MoYtVB5gT5HvhzHF4TAHuztRk3tmXffGViTbJTgMEirJvJkCgmP+Bz/OEAy47NBAeI7W5XlTa9ylUf9k/FR9Vf5G2IGAosyRoGHE5aEPglWLcx1RioBX9yE/PEC8ZDiS7Qlwf2VfQ6H4YFjV0W/U1NPZtx9/cvv0PrIiflZvMkwTEWaACwpS3TWhgo79jSymJbg+BHOIqLJ2MiJo209EarfrGAurnmwkf8BpEzO4GsZPmeYHpNtHcowXM97jz4cQ7s0ge4onvVaRl5XP+XdHoZy+1eouTQqR+Mgpwq9+IdSpIDBJTTtXYTqUH10uagWqe4H3ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GcjR9poDff4SbzLKXa2SuCbPlqGI27TSL1uWa6ZqDU=;
 b=BDQCnpK9J5Q7R5Ho1TB52FKJzUA77y6DpUldtWvZWO4bsuTF9SDE3a3PXwBHnzMg49GGTZsGGVlaGn13jUmNFdRqzNqI5NmoFThrw4SMzGX77Rap/XSWWaCcvA2LiBTYdenR2y0iCfPXR3TzkDuPx0fzz/CVKI6JncDmawoYYIaGWIkZKTAKjz8i9iOK2QJEfl2PJ7/70q6eFXHO+QSX4lqIBBiHRH8KYs/D8+LzNjbCfNnwv+IigWWfMFQ7Wnjv74WSxFPLsFgkVmJfwkJyUJ4x1sRwoLEdwUrDzEENlNV+6UJXqWPrI9vaMt1YNoxexu59+TIEtHt+X99F5vLoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GcjR9poDff4SbzLKXa2SuCbPlqGI27TSL1uWa6ZqDU=;
 b=RWjZdFRun9mh//PvUkotc82WhBvqpYqsSRPQJtWZDsjNEj491spe154m6QOVT9G6/LGt6PcDApEYJ6j2Npn1j+ZF/G95G9JzXrbu5VrzRb4aO5y/RhtHu2gGqHBSp39MWTn64T2L2bMrUgPlo4xOEhmx76jIWHP23tfC8ftjmgk=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by CH0PR10MB7498.namprd10.prod.outlook.com (2603:10b6:610:18e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Mon, 30 Jan
 2023 09:34:26 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::6c1:eae9:196d:f601]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::6c1:eae9:196d:f601%9]) with mapi id 15.20.6064.020; Mon, 30 Jan 2023
 09:34:25 +0000
Message-ID: <31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com>
Date:   Mon, 30 Jan 2023 15:04:09 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [bug-report] rasdaemon doesnot report new records.
Cc:     William ROCHE <william.roche@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>, rostedt@goodmis.org,
        LKML <linux-kernel@vger.kernel.org>,
        "harshit.m.mogalapalli@gmail.com" <harshit.m.mogalapalli@gmail.com>
To:     linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|CH0PR10MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 097de91a-1f79-4186-26a6-08db02a52d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mss+IzKsfkyXNVMl3TphqEb3ALl5RhtiCqFUIpacHyqb8DnG0dPkAZ26Owl64UIpteS4U/ALK7uObnWiCHkAZDr2XCN/4bm7sFjwCW0FBM22jofjbvKBVL1yTY5Q+j9zOlD/u0Lgbbi3O3OGKFoLdM7J1uSe3wbpWtM2GuytyTrH2hMV3irozBv3ZzhJo3uEQrq3hmkOinC9JsJk75ZwVC3MQw7psMOQQwjOw0qpow8pSwMXYM2s4rFOImbP6L/rOB7+rBPTpxtbbunwDcSMatTPsd4F0A6vJAY7PcOzUjVmxHOX/OLTOXnI1qwDja75fyy6rvmzb4AaAjqoADeYeqGna88UieEjI8fG0syBwtJqzP59XBVsgrbrri08iz0VxpLhLTOYrnDmUeM9YF1YlLo18T+86/N4Y+3uMp/NExZiaxyKmwgQKOnPjf9QWDrYBm6+g0c3987Bgoqygd0T1gjHDqhdKYcqC1Syc+azdz5IaEQdBFmJGEiM1sDHJPieyiBjQKvWuU+DTU3Ka+2OGNzKh+bWyakMDe6Pi8tdTL0kj2/dBVqJBa1niLZzQrQz8Of0YEclLqXg3gXLnnouiyarO0jL0x5PQIGz3uWUFO/ilGMeGQ5a82HZxSNLdxX6pKFta6bd/CDLIUigBHQmNW+t4ukjMYBHJcddRcavxfy/fIZ5CfEneaNSFKAAXnIbmQRZbu2WwdUCdDe0vQmw2l4gv1uFi+fqxysHpGbvC3ukaz70QXefz5rT+0IEKxEWkTB15Gi7njC4CU9zgO9B8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(8676002)(41300700001)(4326008)(66476007)(66556008)(6666004)(6506007)(8936002)(66946007)(316002)(31686004)(5660300002)(54906003)(83380400001)(2906002)(36756003)(26005)(966005)(478600001)(6486002)(6512007)(186003)(86362001)(31696002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1grRWQ3azFOc2Yza1RHRlFPMWxmOEN4YXJ6cFBxS3RMdndtb3VMRjVGT0Fo?=
 =?utf-8?B?WDFCcVVPVVl2Y1M1OURaTFBEZ2cwa3pFUDhPUnludEFYejJTdGpXeE40Ny9u?=
 =?utf-8?B?ZkZWeWVlSEFyeHJuTUR2bTVGSXdYS2FnT1FjdXVtMC80SUp5M3g1Z2FHd20y?=
 =?utf-8?B?b3JyeWMxNDNzZ056ZFlGWkF5SFdualNHSVNoMnNRTTJYYU1xVDJUTHhKSFpO?=
 =?utf-8?B?dTBJK3RkOElCRk0rTzFLZHZrd1Z6L2hRMGM0OGhXZkxXeC9GUTBrWTNjeGQw?=
 =?utf-8?B?R1MvN0s2MSt4Nmd5czk0K1hDRnZ5Vmo1YlFXSUlDZnZSY1NLTzJqOWh6R0FZ?=
 =?utf-8?B?d2YzUVlQREt0dGdlZmhpV2FvTUxONFBaNlBicVRFRU1oNG10UlMxZmwzYjNS?=
 =?utf-8?B?M1p1TXNSeFVGZXQvNzQ3OVg2VWhndFBrQUxQNDJhd2REbjcwdVJCZ2I5Y3A0?=
 =?utf-8?B?RTJOeS9wdHlVekhHOHRxMVFhSGFiS3MrTWVGNWxucFdCSWFPWThPQnVyWWVu?=
 =?utf-8?B?VHd1NWxkM3dHeGZFZXlTYldVek5sYWxMeDVnK08wWGdkVVVsUEZCeFgxRmNn?=
 =?utf-8?B?a0NwRklPMURHdmpaR0o5bE9OT3RGblpHVWcrMENSWFpPL2R4V1pUQTZGcTR2?=
 =?utf-8?B?VnBsc080OEw5cmhEcHArMjlXS2lCNW9yMXF3c1JobTU4Z242L1VIODdrNS9o?=
 =?utf-8?B?ZVJFeEVCenpNY01vdEZrTlhZN3NqY21MT3VHS0pqSkZuUXRpbUlZSlJxNVdm?=
 =?utf-8?B?SmJXRUZCWC9ZUlhmdWxNczUzRHN0bGpSczhxNy9VN09hVEZWSXBsVk1QVyta?=
 =?utf-8?B?Nm9pZjU2VjdwbTgrZWpnT0JZWnUzOU1FWFQ0S1FYdytjK1lhT2FnVDdPTkVP?=
 =?utf-8?B?WDlhYkZvYlB0VlBsSWg5cldTcWdNaTdackVJSWVsQ1NsMWNSM1pLZXh1MDZS?=
 =?utf-8?B?S3l2bjdYQTM0K21LSlk3WUtGdDRsMVhTd0xaczFwcXIvNnRIMHhSRVQ1Y2RO?=
 =?utf-8?B?N1VsV3pPa2E3U0s3c2taelZVb1VseUlRdFlVMXdOY2VMK0JKdWhSMlpYdWxm?=
 =?utf-8?B?cE5WdWpmM2dUNmRwaHkxQXZ1N1FtQ09GSjNSMUVMOW5ZMmljL3NEam1tdXNT?=
 =?utf-8?B?dGsxTDdqS0RUcTRBM1ZDOFNPSmVYRWVtUm9ZUHlVaUxsVkpGaGxibVRDcnpa?=
 =?utf-8?B?dW9EbUFUSVJiQ0p3Q0pxNmc1LzlCb0tJTlU5NlZRSUV3b1JTNzlGOUs3b25V?=
 =?utf-8?B?WmYyR3E1RnR3Zis2dHhGbS9COFB3YVlIMStQRGNMUnhQWThob3RHaXVVa0NU?=
 =?utf-8?B?NVl4WW1vclRQcEhxOGFHTmROU2NKTTJJR3JReGdXWi9zNWU1bVdiaFpqVW82?=
 =?utf-8?B?a0RDRjkrMk9Ic0pKMWNHdlZpdWRJaWJkcFZBKzdnM2E1WFo2R3hQYndmaTRZ?=
 =?utf-8?B?YjAvOHA3VkthMzNvR2VWSzY4TktVM3NiSzZWYTRpSEVhZm55ZVFQUjgzak02?=
 =?utf-8?B?Qm1wYU8zWG5LVUs4bllGTmNRZ1dpbmRjcU55TzhvYTFvbDZ6SUVjZ1ZPNlBj?=
 =?utf-8?B?L05udmxZMXo5NlB1bHhjZXlMR25CRWdVM04rQitmUWJWeEdkQ05DQ1FsQTcz?=
 =?utf-8?B?VW5uWk5RTXU3ZjRtLzZZeFROY3VtcThwWitoeDZ2MzdzZ1lBWWVUaTlSdlRj?=
 =?utf-8?B?WWhkakx4cWVPRWpQaU9DRkFsWlBKOXdhV3R1Q2NtMXdBbVpsMVFBUkFPQjZY?=
 =?utf-8?B?SllBcmwybEtLbnEwWTVVKzdpYStQK21iR3lCbHNGT1ZRbWhpQ1BlbEpRaXJl?=
 =?utf-8?B?OVpyd250Y3l3RUgwUHJGb213NTNkK3prVDNKaXdGRktJaDJqSlhDMFBraUlU?=
 =?utf-8?B?QXVkUHlBWmw3aVkwcE51TnhEWFFqVEVFTjlBaFpubXZDakliVnZtUXViVGRk?=
 =?utf-8?B?Ym1oMzc1MG1nSHRxOHAvMW9tMEZreDA1SmhmM1hvcno3VXJ2M1NKWUpMemE2?=
 =?utf-8?B?RnZwMUFSejlFRjVrT21hWVc1RUE5RldoMThqdWc5c0lYcGk2TllaT0IvVDAx?=
 =?utf-8?B?S29KUzlWOVpYVjJlVnBObmF0K2ZEVmwwTzVxbFp5RklQcVdQWDdRcVd2RUxE?=
 =?utf-8?B?aE1oTzRpQjk3OGJielpqZjdaRXVoUnlhM01tVW14dGhTU1BMNnQ3MnZKbUl2?=
 =?utf-8?Q?jWYNVrk3ZyYlhdOhiF70VwU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B0Ks1NQyhVPpavzhTVVG34VT3cy+zR6kM1kqHifptQBfpQECFnugS3AiC/mQIptiUXpHZzuSZrRxRM2hb0sV8HW53SSkchnMPkYzQLnwlA41X2ddo73l0F0Jqpbj+tNvOOtTBSSGRJeac5IAxT2Az95ielBnKNIgVtmCR2uqsnK57TCP6TcHFiDC0khn20A0cO5NxIeAYOHePWy6kxSzyT5Rn5utXNAD9qwvXHtkC88z10qB9cl2wquXr6R0urMiTBvit2eBDmCoLlxjxXGDbuyXClbcOjENXWps6Kuo14HL18uvRT2Uy2nyJECMpLWt5DDWNAV0uynZIoDz5Gn3q4AgCnRYdL07vMM3QoECMTk9Pbn8ZZL24ouxf1D9s3a62qiSdvh/wfv9bwt3oZHdrzxmpaPJ8eDSoLvU/B0NNkV9wHaHrnaBYFtj8gQuKvulrYplFijLRE2pv4xP23+P/LT1AT3MdyaDR62Ak9qiMxPzkLlKcbGkzLunoyTAdB97KgUnyuvnw4esc3Di7DGdeDEWyHMN0khYDs1mZSwWYBE8OJeDcgvXPsbKXlqPuxO6MeuAvTSULpapRZHuAsCwnPM1DPnh0pHZJU3CCi3VsM6/WyS6wq0LCBoYiXRsNTLWKlktaN3yX5hdlVTNa0O84MBL87BNYwiCS+EkVXUJLlgmcXFQOthp3fLdw5PufT9lz9Ot/mFx3yQ+ks0cJnE5GqajYc9CTQmg1/9wJRnAVnQfEin0zvFg1S4eYZiIun6ioB1qoCNyWwPjCmFJgP3G2TNW0LIUYh+NEnlymGcqldlC5fzggfVol7BQrkCFeB3e
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097de91a-1f79-4186-26a6-08db02a52d39
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 09:34:25.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: My8sfIof06b+SWEEykDt6kRskZzI/HM2qCwaIPYtt+taF+sEEaV+pLHc5PHxVSD6JN8hBQGV7IM4BH2wfNF87W7g+cCfhHotwkCaH6nNoAJ7x3MhJ1ABZnYP7tcO4J4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300091
X-Proofpoint-GUID: 5I1TprOEGOCqo3ghTPmiUKzldbe1JMA6
X-Proofpoint-ORIG-GUID: 5I1TprOEGOCqo3ghTPmiUKzldbe1JMA6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Since kernel 6.1-rc6 rasdaemon fails to update the summary of the records.

When we inject MCE errors, generally ras-mc-ctl --summary should be able
to read new errors, but starting from 6.1-rc6 the summary(count on
number of MCE records) doesnot udpate when we inject new mce errors.

This started happening after this commit
42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
polling block on watermark") -- Commit landed first in 6.1-rc6, 6.1-rc5 
kernel doesnot have this problem.

On reverting this commit, rasdaemon works good(i.e It is able to read
the new mce records).

This continues to happen on latest kernel(v6.2-rc6) as well.

In a Good case -- 6.2-rc6 + revert of 42fb0a1e84ff 
("tracing/ring-buffer: Have polling block on watermark"), post poll read 
happens without being stuck.

openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu0/trace_pipe_raw", 
O_RDONLY) = 4
openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu1/trace_pipe_raw", 
O_RDONLY) = 5
openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu2/trace_pipe_raw", 
O_RDONLY) = 6
openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu3/trace_pipe_raw", 
O_RDONLY) = 7
[...]
poll([{fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6, 
events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 5, -1) = 
1 ([{fd=4, revents=POLLIN}])
read(4, 
"\215~\0\0\0\0\0\0t\0\0\0\0\0\0\0\34\t\2\0\263\0\0\0#\0\0\0\n\1\0\t"..., 
4096) = 4096
newfstatat(AT_FDCWD, "/etc/localtime", {st_mode=S_IFREG|0644, 
st_size=114, ...}, 0) = 0
write(2, "rasdaemon: ", 11rasdaemon: )             = 11
write(2, "mce_record store: 0x56047b270008"..., 33mce_record store: 
0x56047b270008
) = 33


In a case where new records are not updated in summary: -- 6.2-rc6
The reason why the database of records isn't populated, is simply 
because rasdaemon doesn't get notified anymore by the kernel:

openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu0/trace_pipe_raw", 
O_RDONLY) = 4
openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu1/trace_pipe_raw", 
O_RDONLY) = 5
openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu2/trace_pipe_raw", 
O_RDONLY) = 6
openat(AT_FDCWD, 
"/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu3/trace_pipe_raw", 
O_RDONLY) = 7
[...]
poll([{fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6, 
events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 5, -1

--- Stuck here even when we inject MCE-errors.


Before the Commit 42fb0a1e84ff ("tracing/ring-buffer: Have polling block 
on watermark"), an error injection could wake the poll() call on the 
above special files, and I can confirm that the subsequent read() call 
did not hang. With the Commit 42fb0a1e84ff, an error injection doesn't 
wake the poll() call anymore.

We need to let rasdaemon (or any other trace consumer using the per_cpu 
files) retrieve the available information as soon as it is available.

Additional info:
1. 
https://github.com/mchehab/rasdaemon/blob/master/ras-events.c#:~:text=ready%20%3D%20poll(fds%2C%20(n_cpus%20%2B%201)%2C%20%2D1)%3B 
this is the code which is getting hit on rasdaemon side.

2. Changing the buffer_percent to a lower value didnot change the behaviour.


Thanks,
Harshit





